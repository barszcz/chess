require_relative 'board.rb'
require_relative 'computer_player.rb'
require_relative 'human_player.rb'
require_relative 'player.rb'

class Game
  def initialize
    @game_board = Board.new
    @black, @white = HumanPlayer.new(:black, @game_board),
                     ComputerPlayer.new(:white, @game_board)
    @turn = :white
  end

  # TODO should stalemates be treated differently from draws?

  def play
    until @game_board.checkmate?(:black) || @game_board.checkmate?(:white) ||
      @game_board.pieces.size == 2
      @game_board.render
      if @turn == :white
        break if no_valid_moves?(:white)
        @white.play_turn
        @turn = :black
      else
        break if no_valid_moves?(:black)
        @black.play_turn
        @turn = :white
      end
    end

    if @game_board.checkmate?(:black)
      puts "White wins"
    elsif @game_board.checkmate?(:white)
      puts "Black wins"
    else
      puts "Draw"
    end
  end

  private

    def no_valid_moves?(color)
      @game_board.pieces(color).all? { |piece| piece.valid_moves.empty? }
    end

end
