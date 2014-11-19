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

  def valid_moves
    moves.reject do |test_move|
      move_into_check?(test_move)
    end
  end

  def is_on_board?(new_pos)   # TODO move to board
    #assuming a square board
    new_pos.all? { |c| (0...@board.size).include?(c) }
  end

  def move_into_check?(test_move)
    @board.dup.move!(@pos, test_move).in_check?(@color)
  end

  def enemy?(test_color)
    @color != test_color
  end

end
