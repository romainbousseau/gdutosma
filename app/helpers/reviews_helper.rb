module ReviewsHelper

  def user_rented_products
    @rented_products = []
    current_user.rents.each do |rent|
    @rented_products << rent.product
    end
    @rented_products
  end

end
