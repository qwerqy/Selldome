Rails.application.routes.draw do

  get 'welcome/index'
  root 'welcome#index'

  get '/home' => 'home#index', as: "home"

  # Dome Route
  resources :dome, controller: "dome", only: [:index]
  # Listings Routes
  resources :listings, controller: "listings", only: [:show, :update]
  get '/my-listings' => 'listings#my_index', as: "my_listings"
  get '/my-listings/new' => 'listings#new', as: "new_listing"
  post '/my-listings/new' => 'listings#create'
  get '/my-listings/:id/edit' => 'listings#edit', as: "edit_listing"
  get '/get_property_from_place_type' => 'listings#property_from_place_type'
  delete '/my-listings/:id' => "listings#destroy", as: "delete_listing"

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

  # Superadmin
  get "/admin-panel" => "superadmin#index", as: "admin_panel"
  get "/all-users" => "superadmin#all_users", as: "view_users"
  get "/update-users" => "superadmin#update_users", as: "update_users"
  get "/delete/:id" => "superadmin#delete_user", as: "delete_user"
  delete "/delete/:id" => "superadmin#destroy_user", as: "destroy_user"
  get "/update/:id" => "superadmin#update_user", as: "update_user"
  patch "/update/:id" => "superadmin#confirm_update", as: "superadmin_user_edit"

  # Moderator
  get "/moderator-panel" => "moderator#index", as: "moderator_panel"
  get "/pending-verification" => "moderator#pending_verification", as: "pending_verification"
  post "/pending-verification/:id/verify/:verified" => "moderator#verify"
  get "/verified-listings" => "moderator#verified_listings", as: "verified_listings"
  get "/all-listings" => "moderator#all_listings", as: "all_listings"
  get "/view-listing/:id" => "moderator#view_listing", as: "view_listing"
  get "/moderator-edit-listing/:id" => "moderator#edit_listing", as: "moderator_edit_listing"
  get "/moderator-delete-listing/:id" => "moderator#delete_listing", as: "moderator_delete_listing"
  delete "/moderator-delete-listing/:id" => "moderator#destroy_listing", as: "moderator_destroy_listing"

  # Sessions Routes
  resource :session, controller: "sessions", only: [:create]
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"

  # Google OAuth Route
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
