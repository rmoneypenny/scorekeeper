class Player < ApplicationRecord

	has_many :group_players
	has_many :groups, :through => :group_players

	validates :name, presence: true, uniqueness: { case_sensitive: false, :scope => :admin_id}


	def getPlayerID(names, admin)
		ids = []
		names.each do |n|
			ids.push(Player.find_by(name: n, admin_id: admin).id)
		end
		ids
	end

	#check if player has played any games
	def gameCheck
		SevenWonder.where(player_id: self.id).count
	end

end
