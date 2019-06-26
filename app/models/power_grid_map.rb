class PowerGridMap < ApplicationRecord

	require 'csv'

	def getRandomMap(expansions)
		mapExpansion = []
		mapNames = []
		allMaps = PowerGridMap.all
		allMaps.each do |m|
			mapNames.push(m.name)
		end
		mapExpansion.push(mapNames[rand(mapNames.size)])
		mapExpansion.push(expansions[rand(expansions.size)])
		mapExpansion

	end

	def import
		file = File.join('lib', 'seeds', 'powergridmaps.csv')
		text = ""
		CSV.foreach(file) do |line|
			PowerGridMap.create(name: line[0])
		end
	end

end
