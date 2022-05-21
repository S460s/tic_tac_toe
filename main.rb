require_relative 'player'
require_relative 'gameboard'

gameboard = Gameboard.new(3)

gameboard.add_player Player.new('x', 'S460')
gameboard.add_player Player.new('o', 'S461')

gameboard.start_game
