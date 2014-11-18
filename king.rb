require_relative 'stepping_piece'

class King < SteppingPiece
  DELTAS = [[-1, -1],
            [-1, 0],
            [-1, 1],
            [0, -1],
            [0, 1],
            [1, -1],
            [1, 0],
            [1, 1]]
end
