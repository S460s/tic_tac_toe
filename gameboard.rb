require_relative 'clearable'
require_relative 'player'

class Gameboard
  ALLOWED_SIGNS = %w[x o].freeze

  include Clearable

  def initialize(size)
    @winner = false
    @turns_played = 0
    @size = size
    @board = Array.new(size) { |i| Array.new(size) { |j| (j + i * size).to_s } }
    @players = []
  end

  def start_game
    init_players

    until @winner || draw?
      @players.each do |player|
        play_round(player)

        if game_over?(player.sign)
          @winner = player
          break
        end
      end
    end

    announce_winner
  end

  private

  def announce_winner
    print_board
    puts 'GG'

    print_winner
    play_again
  end

  def print_winner
    if draw?
      puts 'Draw!'
    else
      puts "#{@winner.name} won!"
    end
  end

  def play_again
    puts 'Play again (y/n)?'
    ans = gets.chomp

    if ans == 'y'
      reset
    else
      puts 'Thanks for playing!'
    end
  end

  def reset
    initialize @size
    clear
    start_game
  end

  def play_round(player)
    print_board
    index = player.play

    if valid_index?(index)
      update_board!(index.to_i, player.sign)
    else
      handle_invalid_input(index, player)
    end
  end

  def handle_invalid_input(index, player)
    puts "#{index} is an invalid option."
    sleep 1
    play_round(player)
  end

  def print_board
    clear
    @board.each do |row|
      row.each { |sign| print "|#{sign.center(@size)}|" }
      puts
    end
  end

  def init_players
    @players << Player.new('x')
    @players << Player.new('o')
  end

  def draw?
    @turns_played == @size * @size
  end

  def game_over?(sign)
    return true if draw?

    @size.times do |i|
      win_conditions = Array.new(4, true)

      @size.times do |j|
        win_conditions[0] = false if @board[j][i] != sign
        win_conditions[1] = false if @board[i][j] != sign
        win_conditions[2] = false if @board[j][j] != sign
        win_conditions[3] = false if @board[j][@size - 1 - j] != sign
      end
      return true if win_conditions.include?(true)
    end

    false
  end

  def update_board!(index, sign)
    @board[index / @size][index % @size] = sign
    @turns_played += 1
  end

  def valid_index?(index)
    return false unless index.match?(/\A-?\d+\Z/)
    return false if index.to_i > @size * @size

    !ALLOWED_SIGNS.include?(@board.flatten[index.to_i])
  end
end
