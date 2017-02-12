class Game
  attr_accessor :board
  def initialize()
    @board = Array.new(4) { Array.new(4) {Tile.new} }
    add_new_tiles
  end

  def print_board
    puts '-------------------------------'
    puts "#{board[0].map { |tile| tile.value }}"
    puts "#{board[1].map { |tile| tile.value }}"
    puts "#{board[2].map { |tile| tile.value }}"
    puts "#{board[3].map { |tile| tile.value }}"
  end

  def win
    win_check = board.flatten.map { |tile| tile.value }
    win_check.include?(2048)
  end

  def lose
    if lose1 && lose2 && lose3
      return true
    else
      return false
    end
  end

  def lose1
    loss_check = board.flatten.map { |tile| tile.value }
    !loss_check.include?(0)
  end

  def lose2
    board.map { |row| row.each_cons(2) { |a, b| return false if a.value == b.value } }
  end

  def lose3
    board[0].zip(board[1], board[2], board[3]).map { |row| row.each_cons(2) { |a, b| return false if a.value == b.value } }
  end

  def squish(array)
    array.map do |row|
      row.delete_if { |tile| tile.value == 0 }
      row << Tile.new until row.count == 4
    end
  end

  def combine(array)
    squish(array)
    array.map do |row|
      row[0..2].each_with_index do |tile, i|
        if tile.combined == false && row[i+1].combined == false && tile.value == row[i+1].value
          row[i] = Tile.new({value: tile.value + row[i+1].value, combined: true})
          row.delete_at(i+1)
          row << Tile.new({combined: true})
        end
      end
    end
    reset_status
    add_new_tiles
  end

  def reset_status
    board.map { |row| row.map { |tile| tile.combined = false } }
  end

  def shift_left
    combine(board)
  end

  def shift_right
    board.map { |row| row.reverse! }
    combine(board)
    board.map { |row| row.reverse! }
  end

  def shift_up
    @board = board[0].zip(board[1], board[2], board[3])
    combine(board)
    @board = board.transpose
  end

  def shift_down
    @board = board[0].zip(board[1], board[2], board[3])
    board.map { |row| row.reverse! }
    combine(board)
    board.map { |row| row.reverse! }
    @board = board.transpose
  end

  def add_new_tiles
    possibilities = board.flatten.delete_if { |tile| tile.value != 0 }
    new_tiles = possibilities.sample(2)
    new_tiles.map { |tile| tile.value = [2, 4].sample }
  end
end
