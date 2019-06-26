class GameController < ApplicationController

	def setup

		if params[:game] == "SevenWonders"
			swb = SevenWonderBoard.new
			session[:playerBoards] = swb.getRandomBoards(params[:players], params[:finalExpansions])
			redirect_to seven_wonders_path
		end

		if params[:game] == "PowerGrid"
			pgm = PowerGridMap.new
			session[:mapExpansion] = pgm.getRandomMap(params[:finalExpansions])
			session[:players] = params[:players] 
			redirect_to power_grid_path
		end

	end

	def stats
		if params[:game] == "SevenWonders"

		end
	end

end
