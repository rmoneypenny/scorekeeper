class GroupsController < ApplicationController

	def show
		@group = Group.new
		@allPlayers = Player.where(admin_id: current_admin.id)
		@allGroups = Group.where(admin_id: current_admin.id)
		playerGroups = GroupPlayer.new
		@gpArray = playerGroups.getGroupPlayers(current_admin.id, @allGroups, @allPlayers)

		respond_to do |format|
		  format.js
		  format.html
		end
	end

	def create
		@allGroups = Group.where(admin_id: current_admin.id)
		@allPlayers = Player.where(admin_id: current_admin.id)
		@group = Group.new(group_params)
		if !@group.save
			render 'show'
		else
			redirect_to settings_groups_path
			flash[:notice] = "Group Added"
		end
	end

	def delete
		@group = Group.where(admin_id: current_admin, name: params[:name]).first
		@group.destroy
		redirect_to settings_groups_path
		flash[:notice] = "Group Deleted"
	end

	private 

		def group_params
			params.permit(:name).merge(admin_id: current_admin.id)
		end
end
