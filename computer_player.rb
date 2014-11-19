require_relative 'player.rb'

# TODO stalemate

class ComputerPlayer < Player

  PIECE_VALUES = {
    King => 10, # if you can either check or take the queen, check
    Queen => 9,
    Rook => 5,
    Bishop => 3,
    Knight => 2.5,
    Pawn => 1
  }

  def play_turn
    pieces = @game_board.pieces(@color)

    moves = Hash.new([])

    pieces.each do |piece|
      moves[piece.pos] = piece.valid_moves
    end

    moves.reject! { |piece, mvs| mvs.nil? || mvs.empty? }

    capturing_moves = find_captures(@game_board, moves)

    unless promotable_pawns.empty?
      promotable_pawns.first.promote(Queen)
    end

    if capturing_moves.empty?
      moves = moves.to_a
      start_piece = moves.sample
      start = start_piece[0]
      end_pos = start_piece[1].sample
    else
      start = capturing_moves[0][0]
      end_pos = capturing_moves[0][1]
    end

    @game_board.move(start, end_pos, @color)
  end

  private

    def find_captures(board, moves)
      capturing_moves = []
      current_board_value = board_value(board)
      moves.each do |start, moves_arr|
        moves_arr.each do |end_pos|
          new_board_value = board_value(board.dup.move!(start, end_pos))
          # if white, new_board_value should be larger than current_board_value
          # if black, current_board_value should be larger than new_board_value

          if @color == :white
            capturing_moves << [start, end_pos] if new_board_value > current_board_value
          else
            capturing_moves << [start, end_pos] if current_board_value > new_board_value
          end

        end
      end

      capturing_moves.sort!
    end

    def board_value(board)
      white = color_value(board, :white)
      black = color_value(board, :black)
      white - black
    end

    def color_value(board, color)
      board.pieces(color).inject(0) do |acc, piece|
        acc + PIECE_VALUES[piece.class]
      end
    end




  #
  #   def search_moves(board, counter = 5, search_color = color)
  #     if counter == 0
  #       # base condition
  #     elsif search_color == color
  #       # call search_moves, switch color
  #     else
  #       # call search_moves, switch color, decrement
  #     end
  #   end
end
