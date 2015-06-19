require "rails_helper"

RSpec.describe Cart, type: :feature do
  scenario "cart retains items after user logs in" do
    item = Item.create(title: "banana", description: "sweet", price: 1)
    user = User.create(name: "Bam", email_address: "email@address.com", username: "bambam", password: "pass" )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # creates a current_user

    visit item_path(item.id)
    click_button "Add To Cart"
    click_link "Cart"

    expect(page).to have_content(item.title)
    # expect(page).to have_link("Login")
    expect(page).to_not have_link("Checkout")

    visit cart_path

    expect(page).to have_link("Logout", :href => logout_path)
    expect(page).to_not have_link("Login")

    within(".site-wrap") do
      expect(page).to have_content(item.title)
      expect(page).to have_content("quantity: 1")
    end
  end
end