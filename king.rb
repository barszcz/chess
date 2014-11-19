require_relative 'stepping_piece'

class King < SteppingPiece
  def deltas
    [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, -1],
     [0, 1],
     [1, -1],
     [1, 0],
     [1, 1]]
   end

   def render
     @color == :white ? '♔' : '♚'
   end

   def valid_moves
     valid_moves = super
     valid_moves << [rank, 6] if can_castle_kingside?
     valid_moves << [rank, 2] if can_castle_queenside?
     valid_moves
   end

  # private

  # TODO refactor this entire mess

     def can_castle_kingside?
       return false if @board.in_check?(@color)
       return false if @moved
       return false unless @board[[rank, 7]]
       return false if @board[[rank, 5]]
       return false if @board[[rank, 7]].moved # if not moved, will always be rook
       unless move_into_check?([rank, 5])
         dup = @board.dup.move!(@pos, [rank, 5])
         return false if @board[[rank, 6]]
         unless dup[[rank, 5]].move_into_check?([rank, 6])
           return true
         else
           return false
         end
       else
         return false
       end
     end

     def can_castle_queenside?
       return false if @board.in_check?(@color)
       return false if @moved
       return false unless @board[[rank, 0]]
       return false if @board[[rank, 3]]
       return false if @board[[rank, 0]].moved # if not moved, will always be rook
       unless move_into_check?([rank, 3])
         dup = @board.dup.move!(@pos, [rank, 3])
         return false if @board[[rank, 2]]
         unless dup[[rank, 3]].move_into_check?([rank, 2])
           return true
         else
           return false
         end
       else
         return false
       end
     end

     def rank
       @color == :white ? 7 : 0
     end
end
