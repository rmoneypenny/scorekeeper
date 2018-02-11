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
		@admin = Admin.new
	end

	def changeName
		@admin = Admin.new	
	end

	def updatePassword
		@admin = Admin.where(name: params[:name]).first
		if !@admin.authenticate(params[:current_password])
			flash[:error] = "Password is not correct"
			redirect_to settings_password_path
		else
			@admin.update(admin_params)
			if @admin.errors.messages.empty?
				flash[:notice] = "Password Changed!"
				redirect_to settings_password_path
			else
				render 'changePassword'
			end
		end
	end

	def updateName
		@admin = Admin.where(name: params[:old_name]).first
		if !@admin.authenticate(params[:password])
			flash[:error] = "Password is not correct"
			redirect_to settings_name_path
		else
			@admin.update(admin_params)
				if @admin.errors.messages.empty?
					flash[:notice] = "Name Changed!"
					redirect_to settings_name_path
				else
					render 'changeName'
				end
		end
	end

	private

	def admin_params
		params.permit(:name, :password, :password_confirmation)
	end

end
