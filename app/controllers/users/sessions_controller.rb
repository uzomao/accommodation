class Users::SessionsController < Devise::SessionsController

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def create
    p "A resource should be printed here!"
    p auth_options
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)


    yield resource if block_given?
    respond_to do |format|
      format.js {
            set_flash_message(:notice, :signed_in)
            render :template => "remote_content/devise_success_sign_up.js.erb"
            flash.discard
          }
      end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    # set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    flash[:notice] = "Signed out of account"
    yield if block_given?
    respond_to do |format|
      format.js {
        render :template => "remote_content/devise_success_sign_up.js.erb"
        flash.discard
      }
    end
    # respond_to_on_destroy

    # respond_to do |format|
    #   format.js {
    #     # render :template => "remote_content/devise_success_sign_up.js.erb"
    #     flash.discard
    #   }
    # end
  end

  # before_filter :configure_sign_in_params, only: [:create]
  # respond_to :json
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create

  #   respond_with json: "shared/login_modal"
  # end

  # protected
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
