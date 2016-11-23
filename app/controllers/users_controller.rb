class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update ]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def dashboard
    @user = current_user
    @products = @user.products
    @rents_owner = Product.where(user_id: current_user.id).map { |p| p.rents }
    @rents_client = @user.rents
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :email, :password, :photo)
  end
end
