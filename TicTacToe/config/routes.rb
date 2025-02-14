Rails.application.routes.draw do
  root 'games#index'

  get "matches/index"

  get "games/new", to: "games#new"
  post "games", to: "games#create", as: :games
  get "game", to: "games#show", as: :game

  post 'games/move', to: 'games#move', as: :games_move
  post 'games/restart', to: 'games#restart', as: :games_restart
  post 'games/back', to: 'games#back', as: :games_back
  post 'games/exit', to: 'games#exit', as: :games_exit

  post 'games/execute_ai_move', to: 'games#execute_ai_move', as: :games_execute_ai_move

end
