require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can sign up and add items to cart" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    expect(page).to have_css 'article.product', count: 10

    click_link 'Signup'
    sleep 1

    fill_in 'user_first_name', with: 'Test'
    fill_in 'user_last_name', with: 'Account'
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'test12'
    fill_in 'user_password_confirmation', with: 'test12'
    click_button 'Submit'
    sleep 1
    
    find('article.product', match: :first).click_button 'Add'
    sleep 1
    
    
    expect(page).to have_link "My Cart (1)"
    save_screenshot
  end
end
