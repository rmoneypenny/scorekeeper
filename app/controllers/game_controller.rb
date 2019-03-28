class GameController < ApplicationController

	def setup

		if params[:game] == "SevenWonders"
			swb = SevenWonderBoard.new
			session[:playerBoards] = swb.getRandomBoards(params[:players], params[:finalExpansions])
			redirect_to seven_wonders_path
		end

	end

	def stats
		if params[:game] == "SevenWonders"

		end
	end

end
