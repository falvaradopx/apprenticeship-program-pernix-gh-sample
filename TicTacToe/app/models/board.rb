class Board
    attr_accessor :board

    def initialize(matrix)
        @board = matrix # Tablero vacío de 3x3
    end

    def restart 
        @board =  Array.new(3) { Array.new(3, nil) }
    end


    def make_move(row, col, symbol)
        return false unless @board[row][col].nil? # Solo permite jugar en espacios vacíos
        @board[row][col] = symbol
        true
    end
    
    def winner?
        # Comprobaciones de filas, columnas y diagonales
        lines = @board + @board.transpose + [[@board[0][0], @board[1][1], @board[2][2]], [@board[0][2], @board[1][1], @board[2][0]]]
        lines.each do |line|
          return true if line.all? { |cell| cell == 'X' }
          return true if line.all? { |cell| cell == 'O' }
        end
        false
    end

    def draw?
        @board.flatten.none?(&:nil?)# && winner?.nil?
    end


end