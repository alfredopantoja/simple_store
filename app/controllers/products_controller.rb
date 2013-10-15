class ProductsController < ApplicationController

  def show
    @product = Product.find(params[:id])
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

  private

    def product_params
      params.require(:product).permit(:name, :price, :released_at)
    end  
end  
