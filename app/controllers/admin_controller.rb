class AdminController < ApplicationController

	def new
		@admin = Admin.new
	end

	def create
		@admin = Admin.new(admin_params)
		if !@admin.save
			render 'new'
		else
			redirect_to home_path
			flash[:notice] = "Account created!"
		end
	end

	private

	def admin_params
		params.permit(:name, :password, :password_confirmation)
	end

end
