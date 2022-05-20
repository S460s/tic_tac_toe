class Player
  attr_reader :sign, :name

  def initialize(sign, name)
    @sign = sign
    @name = name
  end

  def play
    puts "#{name}'s turn"
    gets.chomp
  end
end
