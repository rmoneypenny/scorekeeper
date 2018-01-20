class Group < ApplicationRecord

	belongs_to :admins

	has_many :group_players
	has_many :players, :through => :group_players

end
