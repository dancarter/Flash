Flash::Application.routes.draw do
  devise_for :users

  resources :cards, except: [:show]
  resources :tags, except: [:show]
  resources :users, only: [:show]
  resources :pages do
    collection do
      match 'search' => 'pages#search', via: [:get, :post], as: :search
    end
  end

  get "/cards/:card_id", to: "cards#index", as: "cards_card"

  get "/tags/:tag_id", to: "tags#index", as: "tags_tag"

  post "/remove/:tag_id", to: "tags#remove", as: "tags_removetag"

  get "/review", to: "pages#review", as: "review"

  get "/share", to: "pages#share", as: "share"

  get "/users/:id/:tag_id", to: "pages#sharetag", as: "share_tag"

  post "/copy/:tag_id", to: "pages#copy", as: "copy"

  root 'pages#home'
end
