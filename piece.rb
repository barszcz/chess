class Piece

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def valid_moves

  end

  def is_on_board?(new_pos)
    #assuming a square board
    new_pos.all? { |c| (0...board.size).include?(c) }
  end

end
