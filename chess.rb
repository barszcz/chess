require_relative 'board.rb'

class Game
  def initialize
    @game_board = Board.new
    @black, @white = HumanPlayer.new(:black, @game_board),
                     HumanPlayer.new(:white, @game_board)
    @turn = :white
  end

  def play
    until @game_board.checkmate?(:black) || @game_board.checkmate?(:white)
      @game_board.render
      @white.play_turn
      @game_board.render
      @black.play_turn
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
      p parsed_input
      start, end_pos = parsed_input
      p start
        if @game_board[start].color == @color
        @game_board.move(start, end_pos)
      else
        raise "You can't move your opponent's pieces!"
      end
  end

  def parse_input(input)
    # expects something like e8 c5 -- two notations separated by a space
    # TODO add error-catching

    input.split(' ').map { |str| parse_algebraic_notation(str) }
  end

  def parse_algebraic_notation(str)
    # expects something like e8
    # TODO add error-catching
    col_string, row_string = str.split('')

    col_num = col_string.ord - 97 # TODO refactor with hash?
                                  # this should be between 0 and 7 (board size)

    row_num = 8 - (row_string.to_i)

    [row_num, col_num]
  end

end
