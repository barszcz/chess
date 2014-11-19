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
      dup[pos] = piece.class.new(pos, piece.color, dup, piece.moved)
    end
    dup
  end

  def in_check?(color)
    king = pieces(color).find { |piece| piece.is_a?(King) }

    pieces.any? do |piece|
      piece.moves.include?(king.pos) && piece.enemy?(color)
    end
  end

  def move(start, end_pos, color)
    piece = self[start]

    if piece.nil?
      raise MoveError.new "No piece at this start position."
    end

    unless piece.valid_moves.include?(end_pos)
      raise MoveError.new "You can't move here!"
    end

    unless piece.color == color
      raise MoveError.new "You can't move your opponent's pieces!"
    end

    # Castling
    if piece.is_a?(King)
      if end_pos[1] - start[1] == 2 #kingside
        move!([start[0], 7],[start[0], 5])
      elsif end_pos[1] - start[1] == -2 #queenside
        move!([start[0], 0],[start[0], 3])
      end
    end
    move!(start, end_pos)

    # castling logic goes here



    self
  end

  def move!(start, end_pos)
    self[end_pos], self[start] = self[start], nil
    self[end_pos].update_pos(end_pos)
    self  # return self so we can chain stuff after board.dup.move!
  end

  def checkmate?(color)
    in_check?(color) &&
    pieces(color).all? { |piece| piece.valid_moves.empty? }
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

  private

    def flip_color(color)
      color == :white ? :light_white : :white
    end

end

class MoveError < StandardError
end
