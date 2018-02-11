class PlayersController < ApplicationController

	def create
		@player = Player.new(player_params)
		@allPlayers = Player.all
		if !@player.save
			render 'show'
		else
			redirect_to settings_players_path
			flash[:notice] = "Player Added"
		end
	end

	def show
		@player = Player.new
		@allPlayers = Player.all
	end

	private 

		def player_params
			params.permit(:name).merge(active: true)
		end

end
