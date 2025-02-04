class GamesController < ApplicationController

  def new
    @mode = params[:mode]  # Recibe si es "singleplayer" o "multiplayer"
    puts "Creando un juego tipo: #{@mode}"
  end
  
  def create
    player1_name = params[:player1_name]
    player1_symbol = params[:player1_symbol]
    player2_name = params[:player2_name].present? ? params[:player2_name] : "IA"
    player2_symbol = params[:player2_symbol].present? ? params[:player2_symbol] : (params[:player1_symbol] == 'X' ? 'O' : 'X')
    difficulty = params[:difficulty] if player2_name == "IA"

    #@game = Game.new(player1_name, player1_symbol, player2_name, player2_symbol)

    session[:game] = {
      player1: { name: player1_name, symbol: player1_symbol },
      player2: { name: player2_name, symbol: player2_symbol },
      difficulty: difficulty,
      board: Array.new(3) { Array.new(3, nil) },
      current_turn: player1_symbol
    }

    #puts "Creando el juego: #{@game}"
    redirect_to game_path
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
end
