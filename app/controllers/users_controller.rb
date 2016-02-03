class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		p @user
		@username = @user.first_name + " " + @user.last_name
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		flash[:notice] = "Your details have been edited successfully"
		redirect_to user_path
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :image)
	end
end
