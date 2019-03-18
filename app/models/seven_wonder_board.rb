class SevenWonderBoard < ApplicationRecord

	require 'csv'

	def import
		file = File.join('lib', 'seeds', '7wondersboards.csv')
		text = ""
		CSV.foreach(file) do |line|
			SevenWonderBoard.create(name: line[0], expansion: line[1])
		end
	end

end
