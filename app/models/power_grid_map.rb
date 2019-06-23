class PowerGridMap < ApplicationRecord

	require 'csv'

	def import
		file = File.join('lib', 'seeds', 'powergridmaps.csv')
		text = ""
		CSV.foreach(file) do |line|
			PowerGridMap.create(name: line[0])
		end
	end

end
