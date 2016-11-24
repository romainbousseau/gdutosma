class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_product, only: [ :show, :destroy]

  def index
    product = params[:product]
    # On vérifie si les params sont vides (en gros c'est si on a appuyé sur "rent an item <=> pas de recherche")
    # On verifie si tous les inputs sont fournis et non vide
    # si c vide -> flash + redirect_to
    unless product.nil?
      product.each_value do |value|
        if value.empty? || value.nil? || value.blank?
          flash[:alert] = "You did not fill all the fields bro"
          redirect_to root_path
          break
        end
      end
    end
    # pour éviter les erreurs on affecte nil a la variable si le user n'a pas effectuer de recherche pour pas que ca pète, a voir si on fait pas ca autrement
    @product_wanted = product.nil? ? nil : product[:product_wanted]
    @location = product.nil? ? nil : product[:location]
    @start_date = product.nil? ? nil : product[:start_date]
    @end_date = product.nil? ? nil : product[:end_end]
    @products = product.nil? ? Product.all.where("hidden = ? AND user_id > ?", false, 1) : Product.all.where("name ILIKE ? AND hidden = ? AND user_id > ?", "%#{@product_wanted}%", false, 1)

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
