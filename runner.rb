require_relative "tile"
require_relative "game"

g = Game.new
until g.win == true || g.lose == true 
  g.print_board
  move = gets.chomp
  case move
    when 'a'
      g.shift_left
    when 's'
      g.shift_down
    when 'd'
      g.shift_right
    when 'w'
      g.shift_up
  end
  if g.win
    puts "You win!"
  end
  if g.lose
    g.print_board
    puts "You lose! Better luck next time."
  end
end
