module ApplicationHelper
  def text_for_notifications
    pending_rents = set_number_of_pending_rents
    validated_rents = set_number_of_validated_rents
    # If there is no pending rents
    if pending_rents.zero?
      # we need to see if there is some validates rents
      if validated_rents > 0
        "You have #{validated_rents} rent(s) in progress"
      else
        "You don't have pending rents"
      end
    # Now we are in the case where there is some pending rents
    else
      # We need to see if there are also validated rents
      if validated_rents > 0
        "You have #{pending_rents} rent(s) that require an answer from you and #{validated_rents} rent(s) in progress"
      else
        "You have #{pending_rents} rent(s) that require an answer from you"
      end
    end
  end

  def number_of_pending_rents
    set_number_of_pending_rents
  end

  private

  def set_number_of_pending_rents
    products_user = current_user.products
    pending_rents = 0
    products_user.each do |product|
      pending_rents += product.rents.where(status: "pending").length
    end
      pending_rents
  end

  def set_number_of_validated_rents
    products_user = current_user.products
    validated_rents = 0
    products_user.each do |product|
      validated_rents += product.rents.where(status: "validate").length
    end
      validated_rents
  end
end
