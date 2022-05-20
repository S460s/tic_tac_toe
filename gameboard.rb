require_relative 'clearable'

class Gameboard
  ALLOWED_SIGNS = %w[x o]
  include Clearable

  def initialize(size)
    @turns_played = 0
    @size = size
    @board = Array.new(size) { |i| Array.new(size) { |j| (j + i * size).to_s } }
    @players = []
  end

  def start_game
    if @players.length != 2
      puts 'Wrong number of players, shutting down.'
      return false
    end

    puts 'Tic Tac Toe!'

    until game_over?
      @players.each do |player|
        update_board(player)
        break if game_over?
      end
    end

    puts 'GG'
    print_board
  end

  def add_player(player)
    @players << player
  end

  private

  def game_over?
    @turns_played == @size * @size
  end

  def update_board(player)
    clear
    print_board
    index = player.play

    if valid_index?(index)
      @board[index.to_i / @size][index.to_i % @size] = player.sign
      @turns_played += 1
    else
      puts "#{index} is an invalid option."
      sleep 1
      update_board(player)
    end
  end

  def print_board
    @board.each do |row|
      row.each { |sign| print "|#{sign.center(@size)}|" }
      puts
    end
  end

  def valid_index?(index)
    return false unless index.match?(/\A-?\d+\Z/)
    return false if index.to_i > @size * @size

    !ALLOWED_SIGNS.include?(@board.flatten[index.to_i])
  end
end
