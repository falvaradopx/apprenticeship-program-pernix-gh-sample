class Game
    include ActiveModel::Model

    attr_accessor :player1, :player2, :player1_name, :player1_symbol, :player2_name, :player2_symbol, :difficulty, :board, :current_turn

    validates :player1_name, :player2_name, presence: true, length: { maximum: 20 }
    validates :player1_symbol, :player2_symbol, presence: true, inclusion: { in: ["X", "O"] }
    validate :unique_symbols
    validate :valid_board

    def initialize(player1_name, player1_symbol, player2_name, player2_symbol, dif = nil, matrix = Array.new(3) { Array.new(3, nil) }, current_turn = player1_symbol)
      puts "hola esta creando #{player1_name} - #{player1_symbol} y #{player2_name} - #{player2_symbol}"
      @player1_name = player1_name
      @player1_symbol = player1_symbol
      @player2_name = player2_name
      @player2_symbol = player2_symbol

      @difficulty = dif
      @board = Board.new(matrix) # Tablero vacío de 3x3
      @current_turn = current_turn

      @player1 = Player.new(player1_name, player1_symbol)
      @player2 = Player.new(player2_name, player2_symbol)
    end

    private

    def unique_symbols
      errors.add(:base, "Los jugadores no pueden tener el mismo símbolo") if player1_symbol == player2_symbol
    end
  
    def valid_board
      errors.add(:board, "Debe ser una matriz de 3x3") unless board.board.is_a?(Array) && board.board.size == 3 && board.board.all? { |row| row.size == 3 }
    end
end
  