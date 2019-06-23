class Admin < ApplicationRecord

	has_many :groups

	has_secure_password

	validates :name, presence: true, uniqueness: true
	validates :password, presence: true

	def import(admin)
		flag = ""
		file = File.join('lib', 'seeds', 'import.csv')
		CSV.foreach(file) do |line|
			
			if line.include?("Players")
				flag = "p"
			elsif line.include?("Seven Wonders Data")
				flag = "s"
			elsif line.include?("Power Grid Data")
				flag = "g"
			end
			
			if flag == "p" && !line.include?("Players")
				Player.create(name: line[0], admin_id: admin, active: true)
			elsif flag == "s" && !line.include?("Seven Wonders Data")
				gameNumber = line[0].to_i
				playerID = Player.find_by(name: line[1], admin_id: admin).id
				boardname = line[2]
				boardID = 0
				line[2] == "Unknown" ? (nil) : (boardID = SevenWonderBoard.find_by(name: boardname).id)
				wins = false
				line[3] == "true" ? (wins = true) : (nil)
				score = line[4].to_i
				datetime = DateTime.parse(line[5])
				SevenWonder.create(game_number: gameNumber, player_id: playerID, board_id: boardID, win: wins, score: score, datetime: datetime, admin_id: admin)		
			elsif flag == "g" && !line.include?("Power Grid Data")
				gameNumber = line[0].to_i
				playerID = Player.find_by(name: line[1], admin_id: admin).id
				mapID = 0
				line[2] == "Unknown" ? (nil) : (mapID = PowerGridMap.find_by(name: line[2]).id)
				win = false
				line[3] == "true" ? (wins = true) : (nil)
				score = line[4].to_i
				money = line[5].to_i
				dateTime = DateTime.parse(line[6])
				PowerGrid.create(game_number: gameNumber, player_id: playerID, map_id: mapID, win: win, score: score, money: money, admin_id: admin, datetime: dateTime)
			end
		end		
	end

end
