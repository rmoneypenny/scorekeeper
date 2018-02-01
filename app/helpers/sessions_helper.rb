module SessionsHelper

	def current_admin
		@current_admin ||= Admin.find_by(id: session[:admin_id])
	end

	def logged_in?
		@current_admin ? (true) : (false)
	end

end
