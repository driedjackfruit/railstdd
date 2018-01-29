require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'association' do
    it { should have_many(:products) }
  end
end