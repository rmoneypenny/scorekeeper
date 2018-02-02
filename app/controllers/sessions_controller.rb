class SessionsController < ApplicationController

	def new
		admin = Admin.where(name: params[:name].downcase).first
		if admin && admin.authenticate(params[:password])
			session[:admin_id] = admin.id
			flash[:notice] = "Logged In"
		else
			flash[:error] = "Invalid User/Pass"
		end
		redirect_to root_path
	end

	def destroy
		session.delete(:admin_id)
		@current_admin = nil
		redirect_to root_path
	end

end
