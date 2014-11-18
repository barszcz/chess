require_relative 'sliding_piece'
class Queen < SlidingPiece
  def move_dirs
     [[-1, 0],
      [1,  0],
      [0, -1],
      [0,  1],
      [-1,-1],
      [-1, 1],
      [1, -1],
      [1,  1]]
  end
end
