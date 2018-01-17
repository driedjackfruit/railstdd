require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }

    it 'There is not HTML in description' do
      product = Product.new(title: 'Some', description: '<p>This is description</p>', price: 10)
      product.save
      expect(product.description).to eq 'This is description'
    end

    it 'Title is lowercase' do
      product = Product.new(title: 'UPPERCASE', description: 'uppercasecase', price: 11)
      product.save
      expect(product.title).to eq 'uppercase'
    end

    it 'Title is shorter than description' do
      product = Product.new(title: 'so short', description: 'long', price: 12)
      product.validate
      expect(product.errors.messages).to include(title: ["Title must be shorter than description"])
    end
  end

  context 'association' do
    it { should belong_to(:category) }
  end
end