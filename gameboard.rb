class Gameboard
  ALLOWED_SIGNS = %w[x o]

  attr_reader :board

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

    until game_over?
      @players.each do |player|
        update_board(player)
        break if game_over?
      end
    end

    puts 'GG'
  end

  def add_player(player)
    @players << player
  end

  private

  def game_over?
    @turns_played == @size * @size
  end

  def update_board(player)
    index = player.play

    if valid_index?(index)
      @board[index / @size][index % @size] = player.sign
      @turns_played += 1
      print_board
    else
      puts "#{index} is an invalid option."
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
    return false if index > @size * @size

    !ALLOWED_SIGNS.include?(@board.flatten[index])
  end
end
