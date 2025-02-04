class Game
    attr_accessor :player1, :player2, :board, :current_turn
  
    def initialize(player1_name, player1_symbol, player2_name, player2_symbol, dif, matrix, current_turn)
      @player1 = Player.new(player1_name, player1_symbol)
      @player2 = Player.new(player2_name, player2_symbol)
      @difficulty = dif
      @board = Board.new(matrix) # Tablero vacío de 3x3
      @current_turn = current_turn
    end
end
  