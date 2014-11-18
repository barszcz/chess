require_relative 'piece'

class SteppingPiece < Piece
  def moves
    DELTAS.map { |row, col| [pos[0] + row, pos[1] + col] }
          .select { |new_pos| is_on_board?(new_pos) }
  end
end
