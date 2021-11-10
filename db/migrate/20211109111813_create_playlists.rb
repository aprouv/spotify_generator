class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.string :name, null: false
      t.string :genre
      t.integer :danceability
      t.integer :energy

      t.timestamps
    end
  end
end
