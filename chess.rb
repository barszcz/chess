require_relative 'board.rb'
require_relative 'computer_player.rb'
require_relative 'human_player.rb'
require_relative 'player.rb'

class Game
  def initialize
    @game_board = Board.new
    @black, @white = ComputerPlayer.new(:black, @game_board),
                     ComputerPlayer.new(:white, @game_board)
    @turn = :white
  end

  # TODO add variable to check turns -- if you ^C on black's turn, it shouldn't
  # be white's turn again

  def play
    until @game_board.checkmate?(:black) || @game_board.checkmate?(:white) ||
      @game_board.pieces.size == 2
      @game_board.render
      if @turn == :white
        @white.play_turn
        @turn = :black
      else
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

end
