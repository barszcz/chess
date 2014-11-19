require_relative 'board.rb'
require_relative 'computer_player.rb'

class Game
  def initialize
    @game_board = Board.new
    @black, @white = HumanPlayer.new(:black, @game_board),
                     HumanPlayer.new(:white, @game_board)
    @turn = :white
  end

  # TODO add variable to check turns -- if you ^C on black's turn, it shouldn't
  # be white's turn again

  def play
    until @game_board.checkmate?(:black) || @game_board.checkmate?(:white)
      @game_board.render
      @white.play_turn
      @game_board.render
      @black.play_turn
    end

    if @game_board.checkmate?(:black)
      puts "White wins"
    else
      puts "Black wins"
    end
  end

end


class HumanPlayer

  attr_reader :color

  def initialize(color, game_board)
    @color = color
    @game_board = game_board
  end

  def play_turn
    begin
      puts "#{@color}: enter input"
      input = gets.chomp
      parsed_input = parse_input(input)
      start, end_pos = parsed_input
      @game_board.move(start, end_pos, @color)
    rescue MoveError => e
      puts e
      retry
    end
  end

  def parse_input(input)
    # expects something like e8 c5 -- two notations separated by a space
    # TODO add error-catching / sanity checks

    input.split(' ').map { |str| parse_algebraic_notation(str) }
  end

  def parse_algebraic_notation(str)
    # expects something like e8
    # TODO add error-catching
    col_string, row_string = str.split('')

    col_num = col_string.ord - 97 # TODO refactor with hash?
                                  # this should be between 0 and 7 (board size)

    row_num = 8 - (row_string.to_i)

    unless col_string.between?('a','h') && row_string.between?('1','8') &&
            col_string.length == 1 && row_string.length == 1
      raise MoveError.new "Invalid move string"
    end

    unless row_num.between?(0, 7) && col_num.between?(0, 7)
      raise MoveError.new "Move coordinates are outside board size"
    end

    [row_num, col_num]
  end

end
