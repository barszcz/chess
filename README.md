#THE STRUCTURE OF THE GAME CODE:

##Pieces:
  ###Sliding pieces (bishop/rook/queen)
SlidingPiece can implement #moves; each subclass will need #move_dirs
  ###Stepping pieces (knight/king)
SteppingPiece can implement #moves; each subclass will need #deltas
  ###The pawn
Who knows.

##Methods of Piece:
  valid_moves
  moves_into_check?(pos)

##Methods of SlidingPiece:
  moves
  move_dirs

##Methods of SteppingPiece:
  moves
  deltas

##Methods of Board:
  in_check?
  move(start, end_pos)
    will raise some exceptions under the conditions given
    will call the piece's move method
  dup
