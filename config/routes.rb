Flash::Application.routes.draw do
  devise_for :users

  resources :cards
  resources :tags

  root 'home#home'
end
