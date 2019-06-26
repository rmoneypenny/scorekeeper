class PowerGrid < ApplicationRecord

	def getExpansions
		["test", "test2", "test3", "test4"]
	end

	def exportData(admin)
		exportPowerGrid = []
		pgData = PowerGrid.where(admin_id: admin)
		pgData.each do |pg|
			singleRecord = []
			player = Player.find_by(id: pg.player_id, admin_id: admin)
			map = "Unknown"
			pg.map_id == 0 ? (nil) : (map = PowerGridMap.find(pg.map_id).name)
			singleRecord.push(pg.game_number.to_s)
			singleRecord.push(player.name)
			singleRecord.push(map)
			singleRecord.push(pg.win.to_s)
			singleRecord.push(pg.score.to_s)
			singleRecord.push(pg.money.to_s)
			singleRecord.push(pg.datetime.to_s)
			exportPowerGrid.push(singleRecord)
		end
		exportPowerGrid
	end

end
