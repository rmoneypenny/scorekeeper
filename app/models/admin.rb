class Admin < ApplicationRecord

	has_many :groups

	has_secure_password

	validates :name, presence: true, uniqueness: true
	validates :password, presence: true

end
