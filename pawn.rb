require_relative 'piece'

class Pawn < Piece

  def initialize(pos, color, board)
    @direction = color == :black ? 1 : -1
    super(pos, color, board)
  end

  def render
    @color == :white ? '♙' : '♟'
  end

  def moves

    moves = []
    one_forward = [@pos[0] + @direction, @pos[1]]
    if is_on_board?(one_forward) && @board[one_forward].nil? # TODO this should call the board
      moves << one_forward
    end

    # this is kind of a hack but it works given standard chess rules
    two_forward = [@pos[0] + @direction * 2, @pos[1]]


    if !(@moved) && moves.size == 1 # kludge. also don't need to check if on board
      moves << two_forward unless @board[two_forward]
    end

    captures = [[@pos[0] + @direction, @pos[1] - 1],
                [@pos[0] + @direction, @pos[1] + 1]]

    captures.select! do |capture|
      is_on_board?(capture) &&
      @board[capture] &&
      @board[capture].enemy?(@color)
    end

    moves.concat(captures)

    moves
  end

  def can_promote?
    (@color == :black && @pos[0] == 7) ||
    (@color == :white && @pos[0] == 0)
  end

  def promote(new_piece)
    @board[@pos] = new_piece.new(@pos, @color, @board)
  end
end
