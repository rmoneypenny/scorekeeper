class SevenWonder < ApplicationRecord

require 'csv'


	def submitScores(names, boards, scores, admin)
		#add group id
		p = Player.new
		b = SevenWonderBoard.new
		gameNumber = self.getGameNumber
		playerIDs = p.getPlayerID(names)		
		boardIDs = b.getBoardIDs(boards)
		standings = self.getStandings(scores)
		datetime = DateTime.now.in_time_zone('Eastern Time (US & Canada)')
		counter = 0
		playerIDs.size.times do |p|
			sw = SevenWonder.create(game_number: gameNumber, player_id: playerIDs[counter], board_id: boardIDs[counter], win: standings[counter], score: scores[counter], datetime: datetime, admin_id: admin)
			counter += 1
		end
	end

	def getGameNumber
		if SevenWonder.all.count == 0
			1
		else
			SevenWonder.last.game_number + 1
		end
	end

	def getStandings(scores)
		standings = []
		scores.map{|s| s.to_i}
		highestScore = scores.sort.last
		scores.each do |s|
			s == highestScore ? (standings.push(true)) : (standings.push(false))
		end
		standings
	end

	#playerRecord = [name, score, win]
	def getPastGames(admin)
		pastGamesData = []
		totalWins = Hash.new(0)
		pastGames = SevenWonder.where(admin_id: admin, datetime: 1.days.ago..DateTime.now)
		pastGames.size > 0 ? (gameNumber = pastGames[0].game_number) : (nil)
		pastGames.each do |p|
			playerRecord = []
			playerID = p.player_id
			name = Player.find_by(id: p.player_id).name
			playerRecord.push(name)
			playerRecord.push(p.score)
			if p.win 
				totalWins[name] = totalWins[name] + 1
				playerRecord.push("win")			
			else
				playerRecord.push("lose")
			end
			#Break between games
			if p.game_number > gameNumber
				pastGamesData.push([" - ", " - ", " - "])
				gameNumber = p.game_number
			end
			pastGamesData.push(playerRecord)
			
		end
		[pastGamesData, totalWins]
	end

	#data from an older version of the app
    def convertOldData(admin)
		file = File.join('lib', 'seeds', 'oldData.csv')
		CSV.foreach(file) do |line|
			gameNumber = line[0].to_i
			playerID = Player.find_by(name: line[1]).id
			score = line[2].to_i
			wins = false
			line[3] == "true" ? (wins = true) : (nil)
			datetime = DateTime.parse(line[4])
			boardname = line[5].split(" - ")
			boardID = 0
			line[5] == "Unknown" ? (nil) : (boardID = SevenWonderBoard.find_by(name: boardname[0]).id)
			SevenWonder.create(game_number: gameNumber, player_id: playerID, board_id: boardID, win: wins, score: score, datetime: datetime, admin_id: admin)
		end


	end

end

