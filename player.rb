class Player
  attr_reader :sign, :name

  def initialize(sign, name)
    @sign = sign
    @name = name
  end

  def play(isFirst = true)
    puts "#{name}'s turn" if isFirst
    ans = gets.chomp
    return ans.to_i if ans.match?(/\A-?\d+\Z/)

    puts 'Invalid input, please try again.'
    play false
  end
end
