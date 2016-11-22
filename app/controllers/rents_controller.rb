class RentsController < ApplicationController
  before_action :find_product, only: [:show, :new, :create, :edit, :update, :destroy]
  def show
    @owner = User.find(@product.user)
    @rent = Rent.find(params[:id])
    @customer = User.find(@rent.user)

  end

  def new
    @rent = current_user.rents.build
  end

  def create
    @rent = current_user.rents.build(rent_params)
    @rent.product = @product
    if @rent.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def find_product
   @product = Product.find(params[:product_id])
  end

  def rent_params
    params.require(:rent).permit(:start_date, :end_date)
  end
end
