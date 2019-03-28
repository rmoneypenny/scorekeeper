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

	#return [groupName[name, highestScore, win%, gamesPlayed]]
	def getStats(groups)
		allStats = []
		groupNames = []
		groupStats = []
		#loop through groups
		groups.each do |g|
			individualGroupStats = []
			groupNames.push(g.name)
			#loop through players
			GroupPlayer.where(group_id: g.id).each do |p|
				playerStats = []
				#puts Sev.exists?(p.player_id)
				if SevenWonder.exists?(player_id: p.player_id)
					player = Player.find_by(id: p.player_id)
					playerStats.push(player.name)
					playerStats.push(self.getHighScore(player))
					playerStats.push(self.getWinPercentage(player))
					playerStats.push(SevenWonder.where(player_id: player.id).count)
					individualGroupStats.push(playerStats)
				end
			end
			groupStats.push(individualGroupStats)
		end
		columns = ["Name", "Highest Score", "Win%", "Number of Games"]
		allStats.push(groupNames, groupStats, columns)
		allStats
	end

	def getRecords(groups)
		records = []
		groupRecords = []
		groups.each do |g|
			highestScore = ["No One", 0]
			highestWinPercentage = ["No One", 0]
			mostGamesPlayed = ["No One", 0]
			GroupPlayer.where(group_id: g.id).each do |p|
				if SevenWonder.exists?(player_id: p.player_id)
					player = Player.find_by(id: p.player_id)
					score = self.getHighScore(player) 
					score > highestScore[1] ? (highestScore = [player.name, score, "Score: "]) : (nil)
					winPer = self.getWinPercentage(player)
					winPer > highestWinPercentage[1] ? (highestWinPercentage = [player.name, winPer, "Win%: "]) : (nil)
					mostPlayed = SevenWonder.where(player_id: player.id).count
					mostPlayed > mostGamesPlayed[1] ? (mostGamesPlayed = [player.name, mostPlayed, "Games Played: "]) : (nil)
				end
			end
			groupRecords.push([highestScore, highestWinPercentage, mostGamesPlayed])
		end
		groupRecords
	end

	def getHistory(admin)
		allRecords = SevenWonder.where(admin_id: admin)
		lastGameNumber = allRecords.last.game_number
		history = []
		lastTen = SevenWonder.where(game_number: (lastGameNumber-10)..lastGameNumber)
		lastTen.each do |t|
			history.push([t.game_number, t.win, Player.find_by(id: t.player_id).name, t.score, t.datetime])
		end
		history
	end

	def getWinPercentage(player)
		playerGames = SevenWonder.where(player_id: player.id)
		total = playerGames.count
		wins = 0
		playerGames.each do |p|
			p.win ? (wins += 1) : (nil)
		end
		total == 0 ? (0) : ((wins.to_f/total.to_f).round(2)*100)
	end

	def getHighScore(player)
		playerGames = SevenWonder.where(player_id: player.id)
		scores = []
		playerGames.each do |p|
			scores.push(p.score.to_i)
		end
		scores.sort!
		scores.last
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

