class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :image
      t.boolean :active?, default: true
      t.integer :inventory
    end
  end
end
