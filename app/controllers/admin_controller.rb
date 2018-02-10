class AdminController < ApplicationController

	def new
		@admin = Admin.new
	end

	def create
		@admin = Admin.new(admin_params)
		if !@admin.save
			render 'new'
		else
			redirect_to root_path
			flash[:notice] = "Account created!"
		end
	end

	def changePassword
		
	end

	def changeName

	end

	def updatePassword
		admin = Admin.where(id: params[:admin_id]).first
		if admin.authenticate(params[:password]) && params[:new_password]==params[:new_password_confirmation]
			puts "SUCCESS"
		else
			puts "FAIIILLLL"
		end
	end

	private

	def admin_params
		params.permit(:name, :password, :password_confirmation)
	end

end
