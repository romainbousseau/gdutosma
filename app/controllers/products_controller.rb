class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_product, only: [ :show, :destroy]

  def index
    @products = Product.all.where(hidden: false)
    @users = User.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
    end
  end

  def show
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def undisplay
    @product = Product.find(params[:product_id])
    @product.hidden = true
    @product.save
    redirect_to products_path
  end

  def unavailable
    @product = Product.find(params[:product_id])
    if @product.available == true
      @product.available = false
      @product.hidden = true
    elsif @product.available == false
      @product.available = true
      @product.hidden = false
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :category, :price, photos: [])
  end

end
