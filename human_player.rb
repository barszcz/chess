require_relative 'player'

class HumanPlayer < Player

  # attr_reader :color
  #
  # def initialize(color, game_board)
  #   @color = color
  #   @game_board = game_board
  # end

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
    unless promotable_pawns.empty?
      begin
        allowed_promotions = %w(Knight Queen Rook Bishop)
        puts "You get to promote a pawn! What do you want to promote to?"
        promotion = gets.chomp.capitalize
        unless allowed_promotions.include?(promotion)
          raise MoveError.new "Choose a valid piece type."
        end
        promotable_pawns.first.promote(Object.const_get(promotion))
      rescue MoveError => e
        puts e
        retry
      end
    end
  end

  private

    def parse_input(input)
      # expects something like e8 c5 -- two notations separated by a space
      # TODO add error-catching / sanity checks

      input.split(' ').map { |str| parse_algebraic_notation(str) }
    end

    def parse_algebraic_notation(str)
      # expects something like e8
      # TODO add error-catching
      col_string, row_string = str.split('')

      unless col_string.between?('a','h') && row_string.between?('1','8') &&    # do we really need the betweens here? probably not
              col_string.length == 1 && row_string.length == 1
        raise MoveError.new "Invalid move string"
      end

      col_num = col_string.ord - 97 # TODO refactor with hash?
                                    # this should be between 0 and 7 (board size)

      row_num = 8 - (Integer(row_string))

      [row_num, col_num]
    end

end
