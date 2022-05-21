class Player
  attr_reader :sign, :name

  def initialize(sign)
    @sign = sign
    @name = name_init
  end

  def play
    puts "#{name}'s turn"
    gets.chomp
  end

  private

  def name_init
    puts 'Enter a name: '
    gets.chomp
  end
end
