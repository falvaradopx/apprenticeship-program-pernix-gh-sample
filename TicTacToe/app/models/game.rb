class Game
    include ActiveModel::Model

    attr_accessor :player1, :player1_name, :player2_name,:player1_symbol, :player2_symbol,:player2, :draws, :difficulty, :board, :current_turn, :winner

    validates :player1_name, :player2_name, presence: true, length: { maximum: 20 }
    validates :player1_symbol, :player2_symbol, presence: true, inclusion: { in: ["X", "O"] }
    validate :unique_symbols
    validate :valid_board

    def initialize(player1_name, player1_symbol, player2_name, player2_symbol, dif = nil, player1_wins=0, player2_wins=0, draws = 0, matrix = Array.new(3) { Array.new(3, nil) }, current_turn = player1_symbol, fst_move = player1_symbol, winner = nil)
      puts "hola esta creando #{player1_name} - #{player1_symbol} y #{player2_name} - #{player2_symbol}"
      @player1_name = player1_name
      @player1_symbol = player1_symbol
      @player1_wins = player1_wins
      @player2_name = player2_name
      @player2_symbol = player2_symbol
      @player2_wins = player2_wins

      @draws = draws

      @difficulty = dif
      @board = Board.new(matrix)     # Tablero vacío de 3x3
      @current_turn = current_turn  
      @first_move = fst_move    
      @winner = winner

      @player1 = Player.new(player1_name, player1_symbol, player1_wins)
      @player2 = Player.new(player2_name, player2_symbol, player2_wins)
    end

    def restart_game(type)
      @board.restart
      @winner = nil
      if type == "rematch"
        puts "Es un rematch ---------------------------------------"
        puts "La partida pasada empezó #{@first_move}"
        @first_move = @first_move == 'X' ? 'O' : 'X'
        puts "Ahora va a empezar #{@first_move}"
      end
      @current_turn = @first_move
      return self
    end

    def switch_turn
      @current_turn = @current_turn == @player1.symbol ? @player2.symbol : @player1.symbol
    end

    def make_move(row, col)
      if @board.make_move(row, col, @current_turn)
        if @board.winner?
          @player_winner = @current_turn == @player1.symbol ? @player1 : @player2
          @player_winner.wins += 1
          @winner = @player_winner
          return { status: :win, message: "Ha ganado el jugador #{@player_winner.name} (#{@player_winner.symbol})" }
        elsif @board.draw?
          @draws += 1
          return { status: :draw, message: "Hubo un empate" }
        else
          switch_turn
          return { status: :ok, message: "Turno cambiado" }
        end
      else
        return { status: :error, message: "Casilla ya ocupada" }
      end
    end    

    def get_game_data
      return {
        "player1" => {"name" => @player1.name, "symbol" => @player1.symbol, "wins" => @player1.wins}, 
        "player2" => {"name" => @player2.name, "symbol" => @player2.symbol, "wins" => @player2.wins}, 
        "draws" => @draws,
        "difficulty" => @difficulty, 
        "board" => @board.board,    
        "current_turn" => @current_turn,
        "first_move" => @first_move,
        "winner" => @winner
      }
    end    

    private

    def unique_symbols
      errors.add(:base, "Los jugadores no pueden tener el mismo símbolo") if player1_symbol == player2_symbol
    end
  
    def valid_board
      errors.add(:board, "Debe ser una matriz de 3x3") unless board.board.is_a?(Array) && board.board.size == 3 && board.board.all? { |row| row.size == 3 }
    end
end
  