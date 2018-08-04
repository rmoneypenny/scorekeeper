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
  	gpHash.each{|key, value| gpArray.push([key, value, self.playersNotInGroup(allPlayers, value)])}
  	gpArray
  end

  def playersNotInGroup(allPlayers, groupPlayers)
  	playerNames = []
  	allPlayers.each do |p|
		playerNames.push(p.name)
	end
	players = playerNames-groupPlayers
	players
  end



end
