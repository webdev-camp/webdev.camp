module ApplicationHelper
  def title! str
    @title = str
  end
  def description! str
    @description = str
  end
  def description
    @description || @title
  end
  def delayed_image pic
    image_tag( "brands/1.jpg" ,  "data-src" => asset_path(pic) , class: 'swiper-lazy') +
    raw("<div class='swiper-lazy-preloader swiper-lazy-preloader-white'></div>")
  end

  def ssl_hash
    Rails.env.production? ? {protocol: :https } : {}
  end
  def sign_out_link
    link_to "Sign out" , destroy_user_session_url(ssl_hash)
  end

  def secure_registration
    registration_url(:user , ssl_hash )
  end

  # define a bunch of defaults for the best_in_place call
  def resume_in_place field , attributes = {}
    txt = I18n.t("resumes.#{field}")
    br = proc {|txtt| raw(txtt.to_s.gsub("\n" , "<br>")) }
    defaults = { :url => resume_path , place_holder: txt , display_with: br}
    unless [:street , :city , :country].include? field
      defaults.merge! ok_button: "Edit", ok_button_class: "btn btn-success" ,
                      cancel_button: "Cancel" , cancel_button_class:  "btn btn-warning",
                      inner_class:  "form-control" , as: :textarea ,
                      sanitize: false , html_attrs: {rows: 10}
    end
    attributes.reverse_merge! defaults
    best_in_place(@resume , field , attributes)
  end

  def social_link href , kind , &block
    link_to(href , {class: "social-icon social-icon-sm social-#{kind}" , target: :blank } , &block)
  end
end
