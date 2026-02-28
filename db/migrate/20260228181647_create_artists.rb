class CreateArtists < ActiveRecord::Migration[8.0]
  def change
    create_table :artists, partition_key: :company_id do |t|
      t.string :name
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
