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

##Player

###HumanPlayer

###ComputerPlayer
- Generate a tree of all moves up to a certain depth. Assume opponent does the same.
  - Recursive depth-first search.
- Once you reach the base case, return a score.
  - How will the score be calculated?
  - Can use conventional piece values to calculate utility of captures.
  - Assign a large value to check.
  - Fractional values for control of the center?
  - On checkmate, return an arbitrarily large value to ensure you do that.
  - White takes a positive value; black takes a negative value.
- For other cases than the base, process the scores returned by previous cases.
  - How will this work?
- Can optimize by pruning obviously bad moves.
  - If you can be checkmated, don't search that branch anymore.
