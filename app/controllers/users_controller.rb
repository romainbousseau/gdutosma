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
    # On créé un arret vide
    @rents_owner = []
    # On itère dans les produits du current user que s'il a des produits pour éviter les erreurs
    unless @products.length < 0
      @products.each do |product|
    # Cette fois-ci on itère sur ces rents que s'il en a (encore une fois pour pas que ca crash)
         unless product.rents.length < 0
    #si on rentre dans l'itération on push chque rent dans l'array vide (ligne 22)
           product.rents.each { |rent| @rents_owner << rent }
         end
       end
    end
    @rents_client = @user.rents
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :email, :password, :photo, :city, :zip_code, :country)
  end
end
