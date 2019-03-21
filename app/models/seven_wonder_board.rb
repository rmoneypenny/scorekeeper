class SevenWonderBoard < ApplicationRecord

	require 'csv'

	#percentage chance to pick your board
	@@chancePick = 10
	
	def import
		file = File.join('lib', 'seeds', '7wondersboards.csv')
		text = ""
		CSV.foreach(file) do |line|
			SevenWonderBoard.create(name: line[0], expansion: line[1])
		end
	end

	def getExpansions
		allExpansions = SevenWonderBoard.pluck(:expansion).uniq
		swb = []
		swb.push("All")
		allExpansions.each {|a| swb << a}
		swb
	end

	def getRandomBoards(players, expansions)
		selectedBoards = []
		playerBoards = []
		expansions.include?("All") ? (swb = SevenWonderBoard.all) : (swb = SevenWonderBoard.where(expansion: expansions))
		
		swb.each do |s|
			selectedBoards.push(s.name)
		end

		players.each do |p|
			if rand(100) > @@chancePick
				i = rand(selectedBoards.length)
				bname = selectedBoards[i]
				selectedBoards.slice!(i)
				rand(2) == 0 ? (bname << " - A") : (bname << " - B")
				playerBoards.push([p, bname])
			else
				playerBoards.push([p, "Pick your board"])
			end
		end
		playerBoards
	end

	def getAllBoards
		swb = SevenWonderBoard.all
		swbNames = []
		swb.each do |s|
			swbNames.push(s.name + " - A")
			swbNames.push(s.name + " - B")
		end
		swbNames
	end

	def getBoardIDs(boards)
		ids = []
		boards.each do |b|
			nameSideSplit = b.split(" - ") 
			ids.push(SevenWonderBoard.find_by(name: nameSideSplit[0]).id)
		end
		ids
	end

end
