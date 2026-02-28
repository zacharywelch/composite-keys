class CreateSongs < ActiveRecord::Migration[8.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.references :company, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: false, index: false

      t.timestamps
    end
  end
end
