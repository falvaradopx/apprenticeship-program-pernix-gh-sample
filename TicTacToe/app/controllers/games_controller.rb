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
      session[:game] = @game.get_game_data
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
      @game = load_game_from_session
    else
      redirect_to root_path, alert: "No hay juego en curso."
    end
  end

  def load_game_from_session
    game_data = session[:game]

    return Game.new(
      game_data["player1"]["name"], game_data["player1"]["symbol"], 
      game_data["player2"]["name"], game_data["player2"]["symbol"], 
      game_data["player1"]["wins"], game_data["player2"]["wins"],
      game_data["draws"],
      game_data["difficulty"],
      game_data["board"],
      game_data["current_turn"]
    )
  end
  
  def move
    game_data = session[:game]
    
    if game_data
      row, col = params[:row].to_i, params[:col].to_i

      @game = load_game_from_session

      result = @game.make_move(row, col)

      if result[:status] == :error
        flash[:alert] = result[:message]                        # Muestra error en el frontend
      elsif result[:status] == :win or result[:status] == :draw
        session[:game] = @game.get_game_data                    # Guarda la actualización
        flash[:notice] = result[:message]                       # Muestra mensaje de éxito
      else
        session[:game] = @game.get_game_data                    # Guarda la actualización
      end
    end
  
    redirect_to game_path
  end 

  def restart
    puts "Reiniciando.................................."
    @game = load_game_from_session
    session[:game] = @game.restart_game.get_game_data

    redirect_to game_path  # Redirige para actualizar la vista
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
