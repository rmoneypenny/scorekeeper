class GameController < ApplicationController

	def setup

		if params[:game] == "SevenWonders"
			swb = SevenWonderBoard.new
			session[:playerBoards] = swb.getRandomBoards(params[:players], params[:finalExpansions])
			redirect_to controller: 'game', action: 'seven_wonders'
		end

	end

	#delete the playerboards session when submitting the score

	def seven_wonders
		@sevenWonder = SevenWonder.new
		@allPlayers = Player.where(admin_id: current_admin.id)
		@allGroups = Group.where(admin_id: current_admin.id)
		playerGroups = GroupPlayer.new
		@gpArray = playerGroups.getGroupPlayers(current_admin.id, @allGroups, @allPlayers)
		swb = SevenWonderBoard.new
		@expansions = swb.getExpansions
		session[:playerBoards] ? (@playerBoards = session[:playerBoards]) : (@playerBoards = [])
		@allBoards = swb.getAllBoards
		@pastGames = @sevenWonder.getPastGames(current_admin.id)
	end

	def seven_wonders_create
		sw = SevenWonder.new
		sw.submitScores(params[:name], params[:boardname], params[:scores], current_admin.id)
		session.delete(:playerBoards)
		redirect_to controller: 'game', action: 'seven_wonders'
	end

end
