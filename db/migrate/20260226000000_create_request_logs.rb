class CreateRequestLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :request_logs do |t|
      t.string :request_id
      t.string :http_method, null: false
      t.string :path, null: false
      t.string :ip
      t.string :user_agent
      t.string :referer
      t.string :origin
      t.jsonb :params
      t.integer :status
      t.integer :duration_ms
      t.jsonb :metadata

      t.timestamps
    end

    add_index :request_logs, :created_at
    add_index :request_logs, :request_id
    add_index :request_logs, :ip
    add_index :request_logs, :path
  end
end
