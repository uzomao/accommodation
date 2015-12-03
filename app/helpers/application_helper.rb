module ApplicationHelper
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # programatically choose bootstrap class
  def twitterized_type(type)
  	case type
  	when :errors
  	"alert-error"
  	when :alert
  	"alert-warning"
  	when :error
  	"alert-error"
  	when :notice
  	"alert-success"
    when :happy
    "custom-class"
  	else
  	"alert-info"
  	end
  end

  # this will render _flashes partial
  def flash_normal
    render "shared/flashes"
  end

end
