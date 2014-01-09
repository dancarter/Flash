Flash::Application.routes.draw do
  devise_for :users

  resources :cards, except: [:show]
  resources :tags, except: [:show]
  resources :users, only: [:show]


  get "/cards/:card_id", to: "cards#index", as: "cards_card"

  get "/tags/:tag_id", to: "tags#index", as: "tags_tag"

  get "/review", to: "pages#review", as: "review"

  get "/share", to: "pages#share", as: "share"

  root 'pages#home'
end
