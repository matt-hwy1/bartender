class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.references :cocktail, null: false, foreign_key: true
      t.string :name
      t.string :measurement

      t.timestamps
    end
  end
end
