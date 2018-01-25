class ProductsController < ApplicationController
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
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    return redirect_to products_path, notice: 'success' if @product.update(product_params)
    flash.now[:notice] = 'Wrong input.'
    render :edit
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    flash[:notice] = 'Delete fail.'
    flash[:notice] = 'Success' if @product.destroy
    return redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end
end