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
    # will need to remember to set @moved to true in the move logic TODO
    # no need to handle pawn promotion (yet)                        TODO...?

    moves = []
    one_forward = [@pos[0] + @direction, @pos[1]]
    if is_on_board?(one_forward) && piece_at_position(one_forward).nil?
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
      moves << two_forward if piece_at_position(two_forward).nil?
    end

    captures = [[@pos[0] + @direction, @pos[1] - 1],
                [@pos[0] + @direction, @pos[1] + 1]]

    captures.select! do |capture|
      is_on_board?(capture) &&
      piece_at_position(capture) &&
      piece_at_position(capture) != @color
    end

    moves.concat(captures)

    moves
  end
end
