Rails.application.routes.draw do
  root 'games#index'

  get "games/new", to: "games#new"
  post "games", to: "games#create", as: :games
  get "game", to: "games#show", as: :game

  post 'games/move', to: 'games#move', as: :games_move

end
