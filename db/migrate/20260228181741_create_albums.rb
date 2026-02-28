class CreateAlbums < ActiveRecord::Migration[8.0]
  def change
    create_table :albums, partition_key: :company_id do |t|
      t.string :name
      t.references :company, null: false, foreign_key: true
      t.references :artist, null: false, index: false

      t.timestamps

      t.index %i[company_id artist_id]
      t.foreign_key :artists, column: %i[company_id artist_id],
                    primary_key: %i[company_id id]
    end
  end
end
