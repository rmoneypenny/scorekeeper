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
		gp = GroupPlayer.where(group_id: @group.id)
  		gp.destroy_all  	
		@group.destroy
		redirect_to settings_groups_path
		flash[:notice] = "Group Deleted"
	end

	def update
		@groupPlayer = GroupPlayer.new
		@groupPlayer.save_changes(params[:name], params[:players], current_admin)
		redirect_to settings_groups_path
		flash[:notice] = "Group Updated"
	end

	private 

		def group_params
			params.permit(:name).merge(admin_id: current_admin.id)
		end
end
