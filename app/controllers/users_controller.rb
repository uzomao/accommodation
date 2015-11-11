class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@username = @user.first_name + " " + @user.last_name
	end
end
