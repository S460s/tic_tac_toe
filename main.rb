require_relative 'player'
require_relative 'gameboard'

p1 = Player.new('x', 'S460')
p2 = Player.new('o', 'S461')

gameboard = Gameboard.new(3)

gameboard.add_player p1
gameboard.add_player p2

gameboard.start_game
