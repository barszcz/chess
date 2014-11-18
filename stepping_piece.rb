require_relative 'piece'

class SteppingPiece < Piece
  def moves
    deltas.map { |row, col| [@pos[0] + row, @pos[1] + col] }
          .select do |new_pos|
            is_on_board?(new_pos) &&
            (piece_at_position(new_pos).nil? ||
             piece_at_position(new_pos) != @color)
          end
  end
end
