class PowerGridsController < ApplicationController

	def show
		pg = PowerGrid.new
		@allPlayers = Player.where(admin_id: current_admin.id)
		@allGroups = Group.where(admin_id: current_admin.id)
		@expansions = pg.getExpansions
		playerGroups = GroupPlayer.new
		@gpArray = playerGroups.getGroupPlayers(current_admin.id, @allGroups, @allPlayers)
		session[:players] ? (@players = session[:players]) : (@players = [])
		session[:mapExpansion] ? (@mapExpansion = session[:mapExpansion]) : (@mapExpansion = [])
	end


end