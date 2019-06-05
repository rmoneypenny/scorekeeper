class DashboardController < ApplicationController

	def home
	end

	def settings
		respond_to do |format|
	    	format.html
	    	format.csv { send_data export, filename: "export-#{Date.today}.csv" }
	    end
	end

end
