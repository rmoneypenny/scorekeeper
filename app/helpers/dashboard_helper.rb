module DashboardHelper

require 'csv'

	def export
		sevenWonder = SevenWonder.new
		player = Player.new
		powerGrid = PowerGrid.new
		exportSevenWonder = sevenWonder.exportData(current_admin)
		exportPlayer = player.exportData(current_admin)
		exportPowerGrid = powerGrid.exportData(current_admin)
		CSV.generate do |csv|
			csv << ["Players"]
			exportPlayer.each do |p|
				csv << [p]
			end
			csv << ["Seven Wonders Data"]
			exportSevenWonder.each do |sw|
				csv << sw
			end
			csv << ["Power Grid Data"]
			exportPowerGrid.each do |pg|
				csv << pg
			end
		end
	end
	
end
