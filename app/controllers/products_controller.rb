class ProductsController < ApplicationController

  def show
    @product = Product.find(params[:id])
  end  

  def index 
    @products = Product.paginate(page: params[:page])
  end  

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "New product created."
      redirect_to @product
    else 
      render 'new'
    end
  end  

  def edit
    @product = Product.find(params[:id])
  end  

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Product updated"
      redirect_to @product
    else
      render 'edit'
    end
  end  

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Product deleted."
    redirect_to products_url
  end  

  private

    def product_params
      params.require(:product).permit(:name, :price, :released_at)
    end  
end  
