module ProductsHelper

  def product_card_background(product)
    if product.photos?
      cl_image_path(product.photos.first.path)
    elsif product.category == "Sound"
      asset_url("sound.png")
    elsif product.category == "Lights"
      asset_url("lights.png")
    end
  end
end
