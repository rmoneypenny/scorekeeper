class SevenWonder < ApplicationRecord

    # t.integer "game_number"
    # t.integer "player_id"
    # t.integer "board_id"
    # t.boolean "win"
    # t.integer "score"
    # t.datetime "datetime"

	def submitScores(names, boards, scores)
		#puts self.getGameNumber
		p = Player.new
		b = SevenWonderBoard.new
		gameNumber = self.getGameNumber
		playerIDs = p.getPlayerID(names)		
		boardIDs = b.getBoardIDs(boards)
		standings = self.getStandings(scores)
		puts standings
	end

	def getGameNumber
		if SevenWonder.all.count == 0
			1
		else
			#do something else
		end
	end

	def getStandings(scores)
		standings = []
		winningPosition = 0
		currentPosition = 0
		scores.each do |s|
			s.to_i > scores[winningPosition].to_i ? (winningPosition = currentPosition) : (nil)
			standings[currentPosition] = false
			currentPosition += 1
		end
		#TODO tie check
		standings[winningPosition] = true
		standings
	end

end
