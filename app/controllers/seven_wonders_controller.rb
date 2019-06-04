class SevenWondersController < ApplicationController


	def show
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

	def create
		sw = SevenWonder.new
		sw.submitScores(params[:name], params[:boardname], params[:scores], current_admin.id)
		session.delete(:playerBoards)
		redirect_to seven_wonders_path
	end

	def stats
		@allGroups = Group.where(admin_id: current_admin.id)
		playerGroups = GroupPlayer.new
		sw = SevenWonder.new
		@stats = sw.getStats(@allGroups, current_admin.id)
		@records = sw.getRecords(@allGroups, current_admin.id)
		@history = sw.getHistory(current_admin.id)
	end


end