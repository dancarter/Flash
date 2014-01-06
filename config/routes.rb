Flash::Application.routes.draw do
  devise_for :users

  resources :cards, except: [:show]
  resources :tags, except: [:show]
  resources :users, only: [:show]

  get "/(:card_id)", to: "home#home", as: "home_card"

  root 'home#home'
end
