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
		@allPlayers = Player.where(admin_id: current_admin.id)
		@allGroups = Group.where(admin_id: current_admin.id)
		playerGroups = GroupPlayer.new
		@gpArray = playerGroups.getGroupPlayers(current_admin.id, @allGroups, @allPlayers)
		swb = SevenWonderBoard.new
		@expansions = swb.getExpansions
		@playerBoards = session[:playerBoards]
		@allBoards = swb.getAllBoards
	end

end
