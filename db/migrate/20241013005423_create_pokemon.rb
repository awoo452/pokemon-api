class CreatePokemon < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemon do |t|
      t.string :name
      t.integer :external_id
      t.integer :height
      t.integer :weight
      t.jsonb :types

      t.timestamps
    end
  end
end
