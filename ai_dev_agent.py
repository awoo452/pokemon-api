import subprocess
import os
import re
from datetime import datetime
from openai import OpenAI

client = OpenAI()

CHANGELOG = "CHANGELOG.md"
BRANCH_BASE = "ai_dev_agent"


def branch_exists(name):
    return subprocess.call(
        ["git", "show-ref", "--verify", "--quiet", f"refs/heads/{name}"]
    ) == 0


def create_work_branch():
    if not branch_exists(BRANCH_BASE):
        branch_name = BRANCH_BASE
    else:
        date_suffix = datetime.now().strftime("%Y%m%d")
        branch_name = f"{BRANCH_BASE}-{date_suffix}"
        counter = 1
        while branch_exists(branch_name):
            branch_name = f"{BRANCH_BASE}-{date_suffix}-{counter}"
            counter += 1

    subprocess.check_call(["git", "checkout", "-b", branch_name])
    print("Created branch:", branch_name)

# -----------------------------
# create work branch
# -----------------------------

create_work_branch()

# -----------------------------
# get repository files
# -----------------------------

files = subprocess.check_output(["git","ls-files"]).decode().splitlines()

ignore = [
    "CHANGELOG.md",
    ".gitignore"
]

files = [f for f in files if f not in ignore]

if not files:
    print("No repo files found.")
    exit()

file_list = "\n".join(files[:40])

# -----------------------------
# AI selects file
# -----------------------------

selection_prompt = f"""
You are reviewing a software repository.

Choose ONE file that could benefit from a small improvement.

Allowed improvements:
- documentation
- readability
- comments
- README cleanup

Return ONLY the filename.

FILES:
{file_list}
"""

resp = client.responses.create(
    model="gpt-4.1",
    input=selection_prompt
)

target = resp.output_text.strip()

print("Selected file:", target)

if target not in files:
    print("Model returned invalid file. Aborting.")
    exit()

# -----------------------------
# read file
# -----------------------------

with open(target,"r") as f:
    original = f.read()

# -----------------------------
# AI improves file
# -----------------------------

improve_prompt = f"""
Improve this file slightly.

Rules:
- do not change functionality
- only readability or documentation
- return the FULL updated file
- no explanation

FILE:
{original}
"""

resp2 = client.responses.create(
    model="gpt-4.1",
    input=improve_prompt
)

updated = resp2.output_text

if updated.strip() == original.strip():
    print("No improvement made.")
    exit()

# -----------------------------
# write file
# -----------------------------

with open(target,"w") as f:
    f.write(updated)

print("File updated.")

# -----------------------------
# generate diff
# -----------------------------

diff = subprocess.check_output(["git","diff",target]).decode()

if not diff.strip():
    print("No diff detected.")
    exit()

# -----------------------------
# AI writes changelog entry
# -----------------------------

changelog_prompt = f"""
Describe this change as ONE short present-tense fact for a changelog bullet.
The file path is added separately; do not repeat it.

Rules:
- 5 to 15 words
- no punctuation at start
- no explanation

DIFF:
{diff}
"""

resp3 = client.responses.create(
    model="gpt-4.1",
    input=changelog_prompt
)

entry = resp3.output_text.strip()

print("Changelog entry:", entry)

# -----------------------------
# insert into CHANGELOG (Rails playbook, Rule 2)
# -----------------------------
# One versioned entry per commit, and each bullet names the file it touches.
# If the top entry is not in HEAD's copy of the file it is still in progress,
# so the bullet joins it instead of minting another version. This script only
# makes behavior-free edits, so a new entry is always a PATCH bump.

HEADING = re.compile(r"^## \[(\d+)\.(\d+)\.(\d+)\]", re.M)
TODAY = datetime.now().strftime("%Y-%m-%d")
bullet = f"- `{target}`: {entry}\n"


def published_versions():
    head = subprocess.run(
        ["git", "show", f"HEAD:{CHANGELOG}"], capture_output=True, text=True
    ).stdout
    found = {tuple(map(int, m)) for m in HEADING.findall(head)}
    subjects = subprocess.run(
        ["git", "log", "--format=%s", "-n", "100"], capture_output=True, text=True
    ).stdout
    for subject in subjects.splitlines():
        m = re.fullmatch(r"\s*v?(\d+)\.(\d+)\.(\d+)\s*", subject)
        if m:
            found.add(tuple(map(int, m.groups())))
    return found


if not os.path.exists(CHANGELOG):
    with open(CHANGELOG, "w") as f:
        f.write("# Changelog\n\n")

with open(CHANGELOG, "r") as f:
    text = f.read()

published = published_versions()
top = HEADING.search(text)
top_version = tuple(map(int, top.groups())) if top else None

if top and top_version not in published:
    # In progress: the bullet goes under the top entry's "### Changed".
    next_entry = HEADING.search(text, top.end())
    section_end = next_entry.start() if next_entry else len(text)
    changed = re.search(r"^### Changed\n", text[top.end():section_end], re.M)
    if changed:
        at = top.end() + changed.end()
        text = text[:at] + bullet + text[at:]
    else:
        at = text.index("\n", top.end()) + 1
        text = text[:at] + "### Changed\n" + bullet + text[at:]
    version = ".".join(map(str, top_version))
else:
    newest = max(published, default=top_version or (0, 0, 0))
    version = f"{newest[0]}.{newest[1]}.{newest[2] + 1}"
    new_entry = f"## [{version}] - {TODAY}\n### Changed\n{bullet}\n"
    at = top.start() if top else len(text)
    text = text[:at] + new_entry + text[at:]

with open(CHANGELOG, "w") as f:
    f.write(text)

print(f"CHANGELOG updated under {version}.")
