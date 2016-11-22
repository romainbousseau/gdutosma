class RentsController < ApplicationController

  def show
    @product = Product.find(params[:product_id])
    @rent = Rent.find(params[:id])
  end
end
