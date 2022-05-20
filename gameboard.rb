class Gameboard
  ALLOWED_SIGNS = %w[x o]

  attr_reader :board

  def initialize(size)
    @size = size
    @board = Array.new(size) { |i| Array.new(size) { |j| (j + i * size).to_s.center(size) } }
    @players = []
  end

  def valid_index?(index)
    return false if index > @size * @size

    !ALLOWED_SIGNS.include?(@board.flatten[index].strip)
  end

  def update_board(player)
    index = player.play

    if valid_index?(index)
      @board[index / @size][index % @size] = player.sign.center(@size)
      print_board
    else
      puts "#{index} is an invalid option."
      update_board(player)
    end
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
