require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'queen'
require_relative 'pawn'
require_relative 'rook'

class Board

  attr_reader :grid

  def [](pos)
    x, y = pos
    # p x
    # p y
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def initialize(start = true)
    @grid = Array.new(8) { Array.new(8) }
    set_pieces if start
  end

  def set_pieces
    # pawns
    @grid[1].each_index { |i| @grid[1][i] = Pawn.new([1,i], :black, self) }
    @grid[6].each_index { |i| @grid[6][i] = Pawn.new([6,i], :white, self) }
    # back rows
    back = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    @grid[0].each_index { |i| @grid[0][i] = back[i].new([0,i], :black, self) }
    @grid[7].each_index { |i| @grid[7][i] = back[i].new([7,i], :white, self) }
  end

  # check it.
  # should refactor to avoid having magic numbers
  # this and set_pieces
  def dup
    dup = Board.new(false)
    (0..7).each do |row|
      (0..7).each do |col|
        piece = self[[row,col]]
        if piece
          dup[[row,col]] = piece.class.new([row,col], piece.color, dup)
        end
      end
    end
    dup
  end

end
