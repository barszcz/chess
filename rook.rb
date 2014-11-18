require_relative 'sliding_piece'
class Rook < SlidingPiece
  def move_dirs
    [[-1,0],
    [1, 0],
    [0, -1],
    [0, 1]]
 end
end
