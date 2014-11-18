require_relative 'piece'

class SteppingPiece < Piece
  def moves
    deltas.map { |row, col| [@pos[0] + row, @pos[1] + col] }
          .select do |new_pos|
            is_on_board?(new_pos) &&
            (@board[new_pos].nil? || @board[new_pos].color != @color)
          end
  end
end
