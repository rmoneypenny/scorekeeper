class PlayersController < ApplicationController

	def create
		@player = Player.new(player_params)
		@allPlayers = Player.all
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
		respond_to do |format|
		  format.js
		  format.html
		end
	end

	def update
		player = Player.where(name: params[:name]).first
		player.update(active: false)
	end

	private 

		def player_params
			params.permit(:name).merge(active: true)
		end

end
