class Player
    attr_accessor :name, :symbol, :wins
  
    def initialize(name, symbol, wins)
      @name = name
      @symbol = symbol
      @wins = wins
    end
  end
  