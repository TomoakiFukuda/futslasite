module EventsHelper
  def eventimage_for(event)
    if event.image
      image_tag "/event_images/#{event.image}", :size => "50x50", class: "profile_img"
    else
      image_tag "party_pic.jpg", :size => "100x100", class: "profile_img"
    end
  end


end
