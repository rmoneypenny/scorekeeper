class Player < ApplicationRecord

	has_many :group_players
	has_many :groups, :through => :group_players

	validates :name, presence: true, uniqueness: { case_sensitive: false }

end
