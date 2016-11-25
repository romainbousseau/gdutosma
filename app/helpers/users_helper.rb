module UsersHelper

  def profile_complete?
    parameters_to_avoid = ["reset_password_token", "reset_password_sent_at", "remember_created_at", "provider", "uid", "facebook_picture_url", "token", "token_expiry"]
    boolean = true
    current_user.attributes.each do |key, value|
      unless parameters_to_avoid.include?(key)
        if value.nil?
        boolean = false
        break
        else
        boolean = true
        end
      end
    end
    boolean
  end  
end
