Rails.application.routes.draw do

  get 'welcome/index'
  root 'welcome#index'

  get '/home' => 'home#index', as: "home"

  # Listings Routes
  resources :listings, controller: "listings", only: [:create, :update]
  get '/my-listings' => 'listings#index', as: "my_listings"
  get '/my-listings/new' => 'listings#new', as: "new_listing"
  post '/my-listings(.:format)' => 'listings#create'
  get '/my-listings/:id/edit' => 'listings#edit', as: "edit_listing"

  # Password Route
  resources :passwords, controller: "passwords", only: [:create, :new]

  # Users Routes
  resources :users, controller: "users", only: [:create, :update] do
    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]
  end
  get "/sign_up" => "users#new", as: "sign_up"
  get "/profile/:id" => "users#show", as: "profile"
  get "/profile/:id/edit" => "users#edit", as: "user_edit"

  # Sessions Routes
  resource :session, controller: "sessions", only: [:create]
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"

  # Google OAuth Route
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
