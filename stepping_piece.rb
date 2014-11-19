require_relative 'piece'

class SteppingPiece < Piece
  def moves
    deltas.map { |row, col| [@pos[0] + row, @pos[1] + col] }
          .select do |new_pos|
            is_on_board?(new_pos) &&
            (@board[new_pos].nil? ||   # TODO this should also call the board
             @board[new_pos].color != @color)# This logic might appear somewhere else. Come back later
          end
  end
end
