module Clearable
  def clear
    system('clear') || system('cls')
  end
end
