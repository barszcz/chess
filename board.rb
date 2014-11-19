require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'queen'
require_relative 'pawn'
require_relative 'rook'

require 'colorize'

class Board


  def pieces(color = nil)
    @grid.flatten.compact.select { |piece| color.nil? ? true : piece.color == color }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def size
    @grid.size
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


  def dup
    dup = Board.new(false)
    self.pieces.each do |piece|
      pos = piece.pos.dup
      dup[pos] = piece.class.new(pos, piece.color, dup)
    end
    dup
  end

  def enemy?(pos, color)
    self[pos] && self[pos].color != color
  end

  def in_check?(color)
    king = pieces(color).find { |piece| piece.is_a?(King) }

    pieces.any? do |piece| # TODO add better way of getting opposite color pieces
      piece.moves.include?(king.pos) && piece.color != color # is this logic used anywhere else? (pawn class?)
    end
  end



  def move(start, end_pos, color)
    if self[start].nil?
      raise MoveError.new "No piece at this start position."
    end

    unless self[start].valid_moves.include?(end_pos)
      raise MoveError.new "You can't move here!"
    end

    unless self[start].color == color
      raise MoveError.new "You can't move your opponent's pieces!"
    end

    move!(start, end_pos)

    self  # return self so we can chain stuff after board.dup.move
  end

  def move!(start, end_pos)
    # these seven lines are *almost* dups from move() -- TODO refactor?
    self[end_pos], self[start] = self[start], nil
    self[end_pos].pos = end_pos
    self  # return self so we can chain stuff after board.dup.move
  end

  def render
    color = :light_white
    puts " abcdefgh"
    row_counter = 9

    render = @grid.map do |row|
      color = flip_color(color)
      row_string = row.map do |cell|
        color = flip_color(color)
        cell.nil? ? " ".colorize(background: color) : cell.render.colorize(background:color)
      end.join("")
      row_counter -= 1
      [row_counter.to_s, row_string].join
    end.join("\n")

    puts render
  end

  def checkmate?(color)
    in_check?(color) &&
    pieces(color).all? { |piece| piece.valid_moves.empty? }
  end

  private

    def flip_color(color)
      color == :white ? :light_white : :white
    end

end

class MoveError < StandardError
end
