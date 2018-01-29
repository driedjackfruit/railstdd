class ProductsController < ApplicationController
  before_action :get_product_by_id, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  #before_action :authenticate_admin!

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    return redirect_to products_path if @product.save
    flash.now[:notice] = 'Fail'
    render :new
  end

  def new
    @product = Product.new
  end

  def edit    
  end

  def update    
    return redirect_to products_path, notice: 'success' if @product.update(product_params)
    flash.now[:notice] = 'Wrong input.'
    render :edit
  end

  def show    
  end

  def destroy    
    flash[:notice] = 'Delete fail.'
    flash[:notice] = 'Success' if @product.destroy
    return redirect_to products_path
  end

  private
  def get_product_by_id
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end
end