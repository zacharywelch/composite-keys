class AddCompositeKeys < ActiveRecord::Migration[8.0]
  def change
    add_index :artists, %i[company_id id], unique: true, name: "artists_composite_pkey"
    add_index :albums, %i[company_id id], unique: true, name: "albums_composite_pkey"
    add_index :songs, %i[company_id id], unique: true, name: "songs_composite_pkey"

    add_index :albums, %i[company_id artist_id]
    add_index :songs, %i[company_id album_id]

    add_foreign_key :albums,
                    :artists,
                    column: %i[company_id artist_id],
                    primary_key: %i[company_id id],
                    on_delete: :cascade

    add_foreign_key :songs,
                    :albums,
                    column: %i[company_id album_id],
                    primary_key: %i[company_id id],
                    on_delete: :cascade
  end
end
