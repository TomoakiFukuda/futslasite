module HomeHelper
	def image_for(user)
    if user.image
      image_tag "/user_images/#{user.image}", :size => "50x50", class: "profile_img"
    else
      image_tag "wanko.png", :size => "50x50", class: "profile_img"
    end
  end
end
