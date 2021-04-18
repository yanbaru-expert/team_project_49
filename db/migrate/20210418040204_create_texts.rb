class CreateTexts < ActiveRecord::Migration[6.1]
  def change
    create_table :texts do |t|
      t.integer :genre
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
