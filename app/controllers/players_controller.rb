class PlayersController < ApplicationController

	def create
		@player = Player.new(player_params)
		@allPlayers = Player.where(admin_id: current_admin.id)
		@allPlayers = Player.where(admin_id: current_admin.id)
		if !@player.save
			render 'show'
		else
			redirect_to settings_players_path
			flash[:notice] = "Player Added"
		end
	end

	def show
		@player = Player.new
		@allPlayers = Player.where(admin_id: current_admin.id)
		respond_to do |format|
		  format.js
		  format.html
		end
	end

	def update
		player = Player.where(name: params[:name]).first
		player.update(active: params[:active])
	end

	private 

		def player_params
			params.permit(:name).merge(active: true, admin_id: current_admin.id)
		end

end
