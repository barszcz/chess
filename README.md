#Game code structure

##Pieces
####Sliding pieces (bishop/rook/queen)
- SlidingPiece can implement #moves.
- Each subclass will need #move_dirs, an array of deltas that stores directions.

####Stepping pieces (knight/king)
- SteppingPiece can implement #moves.
- Each subclass will need #deltas.

####The pawn
 TODO

##Methods of Piece:
- is_on_board? checks if a move is on the board
- valid_moves returns all moves that do not put the player into check
  - calls moves, selects from what it returns
- moves_into_check?(pos)
  - calls board.dup and board.in_check?
- move
  - checks if the move is valid
    - if the move is valid (does not put the player into check)
    - so: calls valid_moves

##Methods of SlidingPiece:
- moves
  - returns all possible moves

##Methods of SteppingPiece:
- moves

##Methods of Board:
- in_check?
- move(start, end_pos)

will raise some exceptions under the conditions given

will call the piece's move method
  dup
