class Piece

  attr_reader :color
  attr_accessor :pos


  def inspect
    {
      type: self.class,
      pos: @pos,
      color: @color
    }.inspect

  end



  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def piece_at_position(pos)  # will return the color as a symbol, or nil
    if @board[pos].nil?
      return nil
    else
      return @board[pos].color
    end
  end

  def valid_moves

  end

  def is_on_board?(new_pos)
    #assuming a square board
    new_pos.all? { |c| (0...@board.grid.size).include?(c) }
  end

end
