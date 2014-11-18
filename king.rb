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
end
