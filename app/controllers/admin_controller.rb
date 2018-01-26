class AdminController < ApplicationController

	def new
	end

	def create
		@admin = Admin.new(admin_params)
		if !@admin.save
			render 'register'
		else
			redirect_to home_path
		end
	end

	private

	def admin_params
		params.permit(:name, :password, :password_confirmation)
	end

end
