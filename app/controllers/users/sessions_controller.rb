class Users::SessionsController < Devise::SessionsController

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def create

    respond_to do |format| 
      format.js {
        flash[:notice] = "You are now signed in"
        render :template => "remote_content/devise_success_sign_up.js.erb"
      }
    end
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

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
