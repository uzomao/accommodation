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
    self.resource = warden.authenticate!(auth_options)
      if resource.save
        p "resource could save!"
        p "============================"
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
            sign_in(resource_name, resource)
          }
        end
      else
        p "resource could not save"
        p "============================"
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

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    flash[:notice] = "Signed out."
    yield if block_given?
    render :template => "remote_content/remote_sign_out.js.erb"
  end



  private

  def authenticate_user!
    unless current_user
          flash.now[:alert] = "Invalid username ofr password"
          render :template => "remote_content/devise_errors.js.erb"
          flash.discard(:info)
    end
  end


  # def auth_options
  #   { scope: resource_name, recall: "#{controller_path}#new" }
  # end

end
