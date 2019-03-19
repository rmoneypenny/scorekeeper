class GameController < ApplicationController

	def setup
		puts "Game: #{params[:game]}"
		puts "Players: #{params[:players]}"
		puts "Expansions: #{params[:finalExpansions]}"
	end

	def seven_wonders
		@allPlayers = Player.where(admin_id: current_admin.id)
		@allGroups = Group.where(admin_id: current_admin.id)
		playerGroups = GroupPlayer.new
		@gpArray = playerGroups.getGroupPlayers(current_admin.id, @allGroups, @allPlayers)
		swb = SevenWonderBoard.new
		@expansions = swb.getExpansions
	end

end
