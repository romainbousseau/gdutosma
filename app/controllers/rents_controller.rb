class RentsController < ApplicationController
  before_action :find_product, only: [:show, :new, :create ]
  after_filter :send_recap_email, only: [ :validate ]
  def show
    @owner = User.find(@product.user)
    @rent = Rent.find(params[:id])
    @customer = User.find(@rent.user)

  end

  def new
    @rent = Rent.new
    parameters_to_avoid = ["reset_password_token", "reset_password_sent_at", "remember_created_at", "provider", "uid", "facebook_picture_url", "token", "token_expiry"]
    current_user.attributes.each do |key, value|
      unless parameters_to_avoid.include?(key)
        if value.nil?
          flash[:alert] = "You need to complete your profile before renting a product"
          redirect_to root_path
          break
        else
          @rent = current_user.rents.build
        end
      end
    end
  end

  def create
    @rent = current_user.rents.build(rent_params)
    @rent.product = @product
    if @rent.save
      redirect_to user_dashboard_path(current_user)
    else
      render :new
    end
  end

  def validate
    @product = Product.find(params[:id])
    @rent = Rent.find(params[:id])
    @rent.update(status: "validate")
    @product.update(available: false, hidden: true)
    redirect_to user_dashboard_path(current_user)
  end

  def decline
    @product = Product.find(params[:id])
    @rent = Rent.find(params[:id])
    @rent.update(status: "decline")
    redirect_to user_dashboard_path(current_user)
  end

  def done
    @product = Product.find(params[:id])
    @rent = Rent.find(params[:id])
    @rent.update(status: "done")
    @product.update(available: true, hidden: false)
    redirect_to user_dashboard_path(current_user)
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
