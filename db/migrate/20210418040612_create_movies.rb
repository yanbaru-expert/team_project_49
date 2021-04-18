class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.integer :genre
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
