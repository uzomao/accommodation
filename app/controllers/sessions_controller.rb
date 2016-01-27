class SessionsController < Devise::SessionsController
  before_filter :authenticate_user!

  # respond_to :json

  # def create
  #   p User.new
  #   p current_user
  #   user = User.find_by(email: params[:email])
  #   render json: "NO@@"
  # end


  def create
    # self.resource = warden.authenticate!(auth_options)
    p current_user
    p "Does this stop here"
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end



  private

  def authenticate_user!
    unless current_user
          flash.now[:alert] = "Invalid username of password"
          render :template => "remote_content/devise_errors.js.erb"
          flash.discard(:info)
    end
  end


  # def auth_options
  #   { scope: resource_name, recall: "#{controller_path}#new" }
  # end

end
