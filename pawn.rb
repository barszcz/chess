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
    # no need to handle pawn promotion (yet)                        TODO...?

    moves = []
    one_forward = [@pos[0] + @direction, @pos[1]]
    if is_on_board?(one_forward) && @board[one_forward].nil? # TODO this should call the board
      moves << one_forward
    end

    # this is kind of a hack but it works given standard chess rules
    two_forward = [@pos[0] + @direction * 2, @pos[1]]
    if color == :black
      not_moved = pos[0] == 1
    elsif color == :white
      not_moved = pos[0] == 6
    end

    if not_moved && moves.size == 1 # kludge. also don't need to check if on board
      moves << two_forward unless @board[two_forward]
    end

    captures = [[@pos[0] + @direction, @pos[1] - 1],
                [@pos[0] + @direction, @pos[1] + 1]]

    captures.select! do |capture|
      is_on_board?(capture) &&
      @board[capture] &&                                   # TODO
      @board[capture].color != @color                            # write a method to replace piece_at_position(pos) && piece_at_position(pos) != color
    end

    moves.concat(captures)

    moves
  end
end
