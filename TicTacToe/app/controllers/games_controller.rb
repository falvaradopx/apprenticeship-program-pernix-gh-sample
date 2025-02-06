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
    
    puts "hola esta creando #{player1_name} - #{player1_symbol} y #{player2_name} - #{player2_symbol} con dificultad #{difficulty}"

    @game = Game.new(player1_name, player1_symbol, player2_name, player2_symbol, difficulty)

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
      game_data["difficulty"],
      game_data["player1"]["wins"], game_data["player2"]["wins"],
      game_data["draws"],
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
        save_match(@game)  # Guarda o actualiza el marcador
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

  def exit
    @game = load_game_from_session
    save_match(@game)  # Guarda el estado antes de salir

    session.delete(:game) # Borramos la sesión tras guardar la partida
    session.delete(:match_id)  # Resetear el ID del Match
    redirect_to root_path
  end

  private

  def save_match(game)
    if session[:match_id]  # Si ya existe una partida en la sesión
      match = Match.find_by(id: session[:match_id])  # Busca por ID
      return unless match  # Si no encuentra, no hace nada
    else
      # Primera vez: crea el registro con todos los parámetros
      match = Match.create!(
        player1_name: game.player1.name,
        player1_symbol: game.player1.symbol,
        player1_wins: game.player1.wins,
        player2_name: game.player2.name,
        player2_symbol: game.player2.symbol,
        player2_wins: game.player2.wins,
        difficulty: game.difficulty,
        draws: game.draws
      )
  
      session[:match_id] = match.id  # Guarda el ID en sesión
      return  # No sigue, ya que no necesita actualizar nada más
    end
  
    # Si ya había una partida, solo actualiza los contadores
    match.update!(
      player1_wins: game.player1.wins,
      player2_wins: game.player2.wins,
      draws: match.draws + game.draws
    )
  end
  

  def sanitize_game_params(params)
    params.permit(:player1_name, :player1_symbol, :player2_name, :player2_symbol, :difficulty).transform_values do |value|
      sanitize(value)
    end
  end

  def sanitize(value)
    value.is_a?(String) ? ActionController::Base.helpers.sanitize(value.strip) : value
  end
end
