class Users::RegistrationsController < Devise::RegistrationsController
  # before_filter :configure_sign_up_params, only: [:create]
  # before_filter :configure_account_update_params, only: [:update]
  # clear_respond_to
  # respond_to :json
  skip_before_filter :verify_authenticity_token, :only => :create

  respond_to :html, :js

    def create

      build_resource(sign_up_params)
   
      if resource.save
        respond_to do |format|
          format.html {
            yield resource if block_given?
            if resource.active_for_authentication?
              set_flash_message :notice, :signed_up if is_flashing_format?
              sign_up(resource_name, resource)
              respond_with resource, :location => after_sign_up_path_for(resource)
              else
              set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
              expire_data_after_sign_in!
              respond_with resource, :location => after_inactive_sign_up_path_for(resource)
            end
          }
          format.js {
            flash[:notice] = "Created account, signed in."
            render :template => "remote_content/devise_success_sign_up.js.erb"
            flash.discard
            sign_up(resource_name, resource)
          }
        end
      else
        respond_to do |format|
        format.html {
          clean_up_passwords resource
          respond_with resource
        }
        format.js {
          flash[:alert] = @user.errors.full_messages.to_sentence
          render :template => "remote_content/devise_errors.js.erb"
          flash.discard
        }
        end
      end
    end

 
  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # GET /resource/sign_up
  # def new
  #   @user = User.new
  # end

  # POST /resource
  # def create
  
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private
 
  # Modified Devise params for user login
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :image)
  end


  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
    
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
