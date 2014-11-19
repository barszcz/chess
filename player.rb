class Player
  attr_reader :color

  def initialize(color, game_board)
    @color = color
    @game_board = game_board
  end

  def promotable_pawns
    @game_board.pieces(@color).select(&:can_promote?)
  end
end
