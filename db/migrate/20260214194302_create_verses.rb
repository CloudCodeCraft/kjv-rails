class CreateVerses < ActiveRecord::Migration[8.0]
  def change
    create_table :verses do |t|
      t.string :book
      t.integer :chapter
      t.integer :number
      t.string :text

      t.timestamps

      t.index :book
      t.index [ :book, :chapter, :number ], unique: true
      t.index [ :book, :chapter ], unique: false
    end
  end
end
