require 'singleton'

class Gameboard
  include Singleton

  attr_reader :board

  def initialize
    @board = Array.new(3) { |i| Array.new(3) { |j| (j + i * 3).to_s } }
    @players = []
  end

  def play(player, index)
    @board.flatten[index] = player.sign
  end

  def add_player(player)
    @players << player
  end

  def print_board
    @board.each do |row|
      row.each { |sign| print "|#{sign}|" }
      puts
    end
  end
end
