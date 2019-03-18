class GroupPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :group


  def getGroupPlayers(admin_id, allGroups, allPlayers)
  	gp = GroupPlayer.where(group_id: (allGroups.map{|g| g.id}))
  	gpHash = Hash.new()
  	gp.each do |g| 
  		tempPlayerIDs = []
  		tempPlayerIDs = gpHash[Group.find(g.group_id).name] || []
  		tempPlayerIDs.push(Player.find(g.player_id).name)
  	 	gpHash[Group.find(g.group_id).name] = tempPlayerIDs
    end
    gpArray = []
    #[groupName,[players],[playersNotInGroup]]
    gpHash.each{|key, value| gpArray.push([key, value, self.playersNotInGroup(allPlayers, value)])}
  	emptyGroups = GroupsWithNoPlayers(allGroups, gp, allPlayers)
  	emptyGroups.each do |eg|
  		gpArray.push(eg)
  	end
  	gpArray
  end

  def playersNotInGroup(allPlayers, groupPlayers)
    playerNames = []
    allPlayers.each do |p|
      p.active ? (playerNames.push(p.name)) : (nil)
    end
    players = playerNames-groupPlayers
    players
  end

  def GroupsWithNoPlayers(allGroups, gp, allPlayers)
  	
  	gpids = gp.map{|g| g.group_id}
  	gpids.uniq!
  	allPlayerNames = self.playersNotInGroup(allPlayers,[])
  	emptyGroups = []
  	allGroups.each do|g|
  		if !gpids.include?(g.id)
  			tempArray = []
  			tempArray.push(Group.find(g.id).name)
  			tempArray.push([])
  			tempArray.push(allPlayerNames)
  			emptyGroups.push(tempArray)
  		end
  	end
  	emptyGroups

  end

  def save_changes(name, players, current_admin)

  	group = Group.where(admin_id: current_admin, name: name).first
  	gp = GroupPlayer.where(group_id: group.id)
  	gp.destroy_all
  	players.each do |p|
  		player = Player.where(name: p).first
  		player.groups << group
  	end

  end


end
