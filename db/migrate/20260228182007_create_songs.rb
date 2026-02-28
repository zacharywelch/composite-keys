class CreateSongs < ActiveRecord::Migration[8.0]
  def change
    create_table :songs, partition_key: :company_id do |t|
      t.string :name
      t.references :company, null: false, foreign_key: true
      t.references :album, null: false, index: false

      t.timestamps

      t.index %i[company_id album_id]
      t.foreign_key :albums, column: %i[company_id album_id],
                    primary_key: %i[company_id id]
    end
  end
end
