require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:product1) { create(:product) }
  let!(:product2) { create(:product, title: '12') }
  let!(:product3) { create(:product, title: '000') }


  describe '#index' do
    it 'gets a list of products' do
      products = []
      products << product1
      products << product2
      products << product3
      get :index
      expect(assigns(:products)).to eq products
    end

    it 'render index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe '#new' do
    it 'render new view' do
      get :new
      expect(response).to render_template :new
    end

    it 'get new product' do
      get :new
      expect(assigns(:product)).to be_a(Product)
    end
  end

  describe '#create' do
    def do_request
      post :create, params: { product: params }
    end
    context 'with valid params' do
      let!(:params) { attributes_for(:product) }
      it 'save product' do
        expect { do_request }.to change(Product, :count).by(1)
      end

      it 'redirect to index' do
        do_request
        expect(response).to redirect_to products_path #product_path(assigns(:product))
      end
    end

    context 'with invalid params' do
      let!(:params) { attributes_for(:product, title: '') }
      it 'does not save product' do
        expect { do_request }.to_not change(Product, :count)
      end

      it 'render new view' do
        do_request
        expect(response).to render_template :new
      end
    end
  end

  describe '#show' do
    it 'show right selected product' do
      get :show, params: { id: product1.id }
      expect(assigns(:product)).to eq product1
    end

    it 'render show view' do
      get :show, params: { id: product1.id }
      expect(response).to render_template :show
    end
  end

  describe '#edit' do
    it 'show right selected product' do
      get :edit, params: { id: product1.id }
      expect(assigns(:product)).to eq product1
    end

    it 'render edit view' do
      get :edit, params: { id: product1.id }
      expect(response).to render_template :edit
    end
  end

  describe '#update' do
    def do_request
      put :update, params: { product: params, id: product2.id }
    end

    context 'success' do
      let!(:params) { attributes_for(:product,
                                     title: 'really',
                                     description: 'not really',
                                     price: 79,
                                     category_id: 2) }
      it 'update to database' do
        do_request
        product2.reload
        expect(product2.title).to eq 'really'
      end

      it 'redirect to index view' do
        do_request
        expect(response).to redirect_to products_path
      end
    end

    context 'failure' do
      let!(:params) { attributes_for(:product, title: '', description: 'right?') }
      it 'does not change product' do
        do_request
        product2.reload
        expect(product2.description).to_not eq 'right?'
      end

      it 'render edit view' do
        do_request
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    def do_request
      delete :destroy, params: { id: product1.id }
    end
    it 'click right selected product' do
      do_request
      expect(assigns(:product)).to eq product1
    end

    context 'success' do
      it 'delete product in database' do
        expect { do_request }.to change(Product, :count).by(-1)
      end

      it 'redirect to index view' do
        do_request
        expect(response).to redirect_to products_path
      end
    end
  end
end