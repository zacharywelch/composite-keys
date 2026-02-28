class CreateAlbums < ActiveRecord::Migration[8.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.references :company, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: false, index: false

      t.timestamps
    end
  end
end
