require_relative 'piece'
class SlidingPiece < Piece

  # local variables inherited from Piece are:
  # @pos stores the position of the piece
  # @board stores a pointer to the board
  # @color stores a symbol that represents the color


  def moves
    moves = []
    move_dirs.each do |delta|      # row = y, col = x
       row, col = @pos
       while is_on_board?([row + delta[0], col + delta[1]])
         row += delta[0]
         col += delta[1]
         piece_at_position = @board[[row, col]]
         break if piece_at_position && piece_at_position.color == @color
         moves << [row, col]
         break if piece_at_position # and it's of the opponent's color
       end
    end
    moves
  end

end
