require 'rails_helper'

RSpec.describe "item update page" do
  describe "as a user" do
    describe "when I visit the item show page and click on link to update item" do
      it "I can edit an item's information through an edit form" do
        wand_shop = Merchant.create(name: "Ollivanders", address: "125 Diagon Alley", city: "London", state: "UK", zip: 25126)
        wand = wand_shop.items.create(name: "Vine Wood Wand", description: "Vine wood with a dragon heartstring core.", price: 100, image: "https://images-na.ssl-images-amazon.com/images/I/816nAgnLhXL._AC_SL1500_.jpg", active?:false, inventory: 2)

        visit "/items/#{wand.id}"

        click_on "Edit Item"

        expect(current_path).to eq("/items/#{wand.id}/edit")

        fill_in :name, with: "Vine Wood Wand"
        fill_in :price, with: 100
        fill_in :description, with: "Vine wood with a dragon heartstring core."
        fill_in :image, with: "https://images-na.ssl-images-amazon.com/images/I/816nAgnLhXL._AC_SL1500_.jpg"
        fill_in :inventory, with: 2

        click_button "Update Item"

        expect(current_path).to eq("/items/#{wand.id}")
        expect(page).to have_content("Vine Wood Wand")
        expect(page).to have_content("Price: $100")
        expect(page).to have_content("Vine wood with a dragon heartstring core.")
        expect(page).to have_css("img[src*='https://images-na.ssl-images-amazon.com/images/I/816nAgnLhXL._AC_SL1500_.jpg']")
        expect(page).to have_content("Inventory: 2")

        expect(page).to_not have_content(wand.name)
        expect(page).to_not have_content(wand.description)
        expect(page).to_not have_content("Price: $#{wand.price}")
        expect(page).to_not have_content(wand.description)
        expect(page).to_not have_css("img[src*='https://images-na.ssl-images-amazon.com/images/I/816nAgnLhXL._AC_SL1500_.jpg']")
        expect(page).to_not have_content("Inventory: #{wand.inventory}")
      end
    end
  end
end
