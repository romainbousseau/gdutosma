class RentsController < ApplicationController
  before_action :find_product, only: [:show, :new, :create ]
  after_validate :send_recap_email
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

  def validate
    @product = Product.find(params[:id])
    @rent = Rent.find(params[:id])
    @rent.update(status: "validate")
    @product.update(available: false, hidden: true)
    redirect_to product_rent_path(@rent.product, @rent)
  end

  def decline
    @product = Product.find(params[:id])
    @rent = Rent.find(params[:id])
    @rent.update(status: "decline")
    redirect_to product_rent_path(@rent.product, @rent)
  end

  def done
    @product = Product.find(params[:id])
    @rent = Rent.find(params[:id])
    @rent.update(status: "done")
    @product.update(available: true, hidden: false)
    redirect_to product_rent_path(@rent.product, @rent)
  end

  private

  def find_product
   @product = Product.find(params[:product_id])
  end

  def rent_params
    params.require(:rent).permit(:start_date, :end_date)
  end

  def send_recap_email
    UserMailer.recap(self).deliver_now
  end


end
