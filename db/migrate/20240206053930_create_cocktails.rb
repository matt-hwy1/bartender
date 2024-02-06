class CreateCocktails < ActiveRecord::Migration[7.1]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.string :category
      t.string :container
      t.string :instructions
      t.string :image

      t.timestamps
    end
  end
end
