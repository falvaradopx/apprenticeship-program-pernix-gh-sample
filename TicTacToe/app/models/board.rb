class Board
    attr_accessor :board

    def initialize(matrix)
        @board = matrix # Tablero vacío de 3x3
    end

    def make_move(row, col, symbol)
        return false unless @board[row][col].nil? # Solo permite jugar en espacios vacíos
    
        @board[row][col] = symbol
        true
    end
end