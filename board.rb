require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'queen'
require_relative 'pawn'
require_relative 'rook'

class Board

  attr_reader :grid

  def pieces(color = nil)
    @grid.flatten.compact.select { |piece| color.nil? ? true : piece.color == color }
  end

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
    duplicate = Board.new(false)
    (0..7).each do |row|
      (0..7).each do |col|
        piece = self[[row,col]]
        if piece
          duplicate[[row,col]] = piece.class.new([row,col], piece.color, duplicate)
        end
      end
    end
    duplicate
  end

  def in_check?(color)
    king = @grid.flatten.find { |piece| piece.is_a?(King) && piece.color == color }
    @grid.flatten.any? do |piece|
      next if piece.nil?
      piece.moves.include?(king.pos) && piece.color != color
    end
  end

  def move(start, end_pos)
    if self[start].nil?
      raise ArgumentError.new "No piece at this start position."
    end

    unless self[start].valid_moves.include?(end_pos)
      raise ArgumentError.new "You can't move here!"
    end

    self[end_pos], self[start] = self[start], nil
    self[end_pos].pos = end_pos

    self  # return self so we can chain stuff after board.dup.move
  end

  def move!(start, end_pos)
    if self[start].nil?
      raise ArgumentError.new "No piece at this start position."
    end

    unless self[start].moves.include?(end_pos)
      raise ArgumentError.new "You can't move here!"
    end

    self[end_pos], self[start] = self[start], nil
    self[end_pos].pos = end_pos

    self  # return self so we can chain stuff after board.dup.move
  end

  def render
    @grid.each do |row|
      row.each do |cell|
        print cell.nil? ? ' ' : cell.render
      end
      puts ''
    end

    nil
  end

  def checkmate?(color)
    in_check?(color) &&
    pieces(color).all? { |piece| piece.valid_moves.empty? }
  end

end
