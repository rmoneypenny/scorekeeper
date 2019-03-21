class Player < ApplicationRecord

	has_many :group_players
	has_many :groups, :through => :group_players

	validates :name, presence: true, uniqueness: { case_sensitive: false }

	def getPlayerID(names)
		ids = []
		names.each do |n|
			ids.push(Player.find_by(name: n).id)
		end
		ids
	end


end
