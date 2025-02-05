class GamesController < ApplicationController

  def new
    @mode = params[:mode]  # Recibe si es "singleplayer" o "multiplayer"
    puts "Creando un juego tipo: #{@mode}"
  end
  
  def create
    game_params = sanitize_game_params(params)

    player1_name = game_params[:player1_name]     
    player1_symbol = game_params[:player1_symbol] 
    player2_name = game_params[:player2_name].presence || "IA"
    player2_symbol = game_params[:player2_symbol].present? ? game_params[:player2_symbol] : game_params[:player1_symbol] == 'X' ? 'O' : 'X'
    difficulty = game_params[:difficulty] if player2_name == "IA"
    
    puts "hola esta creando #{player1_name} - #{player1_symbol} y #{player2_name} - #{player2_symbol}"

    @game = Game.new(player1_name, player1_symbol, player2_name, player2_symbol)

    if @game.valid?
      session[:game] = {
        player1: { name: player1_name, symbol: player1_symbol },
        player2: { name: player2_name, symbol: player2_symbol },
        difficulty: difficulty,
        board: @game.board.board,
        current_turn: player1_symbol
      }
      puts "hola esta imprimiendo #{session[:game]}"

      redirect_to game_path
    else
      flash[:alert] = @game.errors.full_messages.join(", ")
      redirect_to games_new_path(mode: difficulty ? "singleplayer" : "multiplayer")
    end
  end

  def show
    game = session[:game] || {}  # Asegura que game no sea nil
    puts "hola esta imprimiendo #{game}"
  
    if game.present?
      @game = Game.new(
        game["player1"]["name"], game["player1"]["symbol"], 
        game["player2"]["name"], game["player2"]["symbol"],
        game["difficulty"],
        game["board"],
        game["current_turn"]
      )
      
    else
      redirect_to root_path, alert: "No hay juego en curso."
    end
  end

  private

  def sanitize_game_params(params)
    params.permit(:player1_name, :player1_symbol, :player2_name, :player2_symbol, :difficulty).transform_values do |value|
      sanitize(value)
    end
  end

  def sanitize(value)
    value.is_a?(String) ? ActionController::Base.helpers.sanitize(value.strip) : value
  end
end
