require 'rails_helper'


describe 'User cans CRUD products', type: :feature do
  it 'can create a product' do
    visit products_path
    expect(page).to have_link 'Create a product'
    click_on 'Create a product'
    expect(page).to have_content 'Create Product'
    fill_in 'Title', with: 'Any book'
    fill_in 'Description', with: 'Any book 1'
    fill_in 'Price', with: 10
    click_on 'Submit'
    expect(page).to have_content 'Any book 1'
  end

  let!(:product) { create(:product) }
  it 'show a product' do
    visit '/products'
    expect(page).to have_content 'Title'
    click_on product.title
    expect(page).to have_content product.description
  end

  context 'Update with valid params' do
    it 'update a product and return to index view' do
      visit '/products'
      expect(page).to have_content 'Edit'
      #click_link product.id
      click_on 'Edit'
      expect(page).to have_content 'Edit product'
      fill_in 'Title', with: 'A'
      fill_in 'Description', with: 'AAA'
      fill_in 'Price', with: 100
      click_on 'Update Product'
      expect(page).to have_content 'success'
    end
  end

  context 'Update with invalid params' do
    it 'cant update' do
      visit '/products'
      expect(page).to have_content 'Edit'
      click_on 'Edit'
      expect(page).to have_content 'Edit product'
      fill_in 'Title', with: ''
      click_on 'Update Product'
      expect(page).to have_content 'Wrong input.'
    end
  end

  it 'delete a product' do
    visit '/products'
    expect(page).to have_content 'Delete'
    click_on 'Delete'
    expect(page).to_not have_content product.title
  end
end