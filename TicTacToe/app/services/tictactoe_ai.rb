module TictactoeAi
  def self.best_move(board, ai_symbol, difficulty)
    player_symbol = ai_symbol == 'X' ? 'O' : 'X'
    puts "IA planeando un movimiento de dificultad: #{difficulty}"
    case difficulty
    when "easy"
      puts "Entro en easy"
      random_move(board)
    when "medium"
      puts "Entro en medium"

      smart_move(board, ai_symbol, player_symbol)
    when "hard"
      puts "Entro en hard"

      minimax_move(board, ai_symbol, player_symbol)
    else
      puts "No entró en ninguno"

      random_move(board)
    end
  end

  private

  def self.empty_positions(board)
    positions = []
    board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        positions << [i, j] if cell.nil? || cell == ''
      end
    end
    positions
  end

  def self.random_move(board)
    empty_positions(board).sample
  end

  def self.smart_move(board, ai_symbol, player_symbol)
    winning_move = find_winning_move(board, ai_symbol)
    return winning_move if winning_move

    blocking_move = find_winning_move(board, player_symbol)
    return blocking_move if blocking_move

    random_move(board)
  end

  def self.minimax_move(board, ai_symbol, player_symbol)
    if board.flatten.all?(&:nil?)
      return [1, 1] if board[1][1].nil?
    end
    best_score = -Float::INFINITY
    best_move = nil

    empty_positions(board).each do |move|
      i, j = move
      new_board = board.map(&:dup)
      new_board[i][j] = ai_symbol

      score = minimax(new_board, false, ai_symbol, player_symbol)

      if score > best_score
        best_score = score
        best_move = move
      end
    end
    best_move
  end

  def self.find_winning_move(board, symbol)
    empty_positions(board).each do |move|
      i, j = move
      new_board = board.map(&:dup)
      new_board[i][j] = symbol
      return move if winner?(new_board, symbol)
    end
    nil
  end

  def self.minimax(board, is_maximizing, ai_symbol, player_symbol)
    return 1 if winner?(board, ai_symbol)
    return -1 if winner?(board, player_symbol)
    return 0 if empty_positions(board).empty?

    best_score = is_maximizing ? -Float::INFINITY : Float::INFINITY

    empty_positions(board).each do |move|
      i, j = move
      new_board = board.map(&:dup)
      new_board[i][j] = is_maximizing ? ai_symbol : player_symbol

      score = minimax(new_board, !is_maximizing, ai_symbol, player_symbol)
      best_score = is_maximizing ? [best_score, score].max : [best_score, score].min
    end
    best_score
  end

  def self.winner?(board, symbol)
    rows = board.any? { |row| row.all? { |cell| cell == symbol } }
    cols = board.transpose.any? { |col| col.all? { |cell| cell == symbol } }
    diag1 = (0..2).all? { |i| board[i][i] == symbol }
    diag2 = (0..2).all? { |i| board[i][2 - i] == symbol }

    rows || cols || diag1 || diag2
  end
end
