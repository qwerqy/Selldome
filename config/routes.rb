Rails.application.routes.draw do

  get '/construction' => "reservations#test"
  get 'welcome/index'
  root 'welcome#index'

  get '/home' => 'home#index', as: "home"

  # Home Route
  get "/home/load" => "home#load_content", as: "load_content"

  # Dome Route
  resources :dome, controller: "dome", only: [:index]
  get "/dome/:place_type" => 'dome#show_place_type', as: "show_place_type"
  get "/dome/show/all" => 'dome#show_all', as: "show_all"
  get "/dome/guests/:no1-:no2" => 'dome#show_by_guests', as: "show_by_guests"
  get "/dome/price/:no1-:no2" => 'dome#show_by_price', as: "show_by_price"


  # Listings Routes
  resources :listings, controller: "listings", only: [:create, :show, :update] do
    # Review Route
    resources :reviews, controller: "review"
    get 'booked_dates' => 'reservations#booked_dates'
    # Reservations Route
    post 'reservations/review_booking', as: 'review_booking'
    resources :reservations do
      # Payment
      get 'payment/new'
      post 'payment/checkout'
    end
  end


  get '/my-listings' => 'listings#my_index', as: "my_listings"
  get '/my-listings/new' => 'listings#new', as: "new_listing"
  post '/my-listings/new' => 'listings#create'
  get '/my-listings/:id/edit' => 'listings#edit', as: "edit_listing"
  get '/get_property_from_place_type' => 'listings#property_from_place_type'
  delete '/my-listings/:id' => "listings#destroy", as: "delete_listing"
  get "/listing/:id/upload-photos" => 'listings#show_upload', as: "show_upload"
  post '/listings/:id/upload-photos' => "listings#upload_photos", as: "listing_upload_photos"
  delete '/listings/:id/remove-photo/:index' => "listings#remove_photo", as: "listing_remove_photo"
  get '/listings/:id/view-photos' => "listings#view_photos", as: "view_photos"


  # Password Route
  resources :passwords, controller: "passwords", only: [:create, :new]

  # Users Routes
  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]
  end
  get "/sign_up" => "users#new", as: "sign_up"
  get "/profile/:id" => "users#show", as: "profile"
  get "/profile/:id/edit" => "users#edit", as: "user_edit"
  patch "/profile/:id/edit" => "users#update", as: "user"
  get "/:id/upload-photo" => "users#upload_photo", as: "user_upload_photo"
  get "/:id/remove-photo" => "users#remove_photo", as: "user_remove_photo"

  # Superadmin
  get "/admin-panel" => "superadmin#index", as: "admin_panel"
  get "/all-users" => "superadmin#all_users", as: "view_users"
  get "/update-users" => "superadmin#update_users", as: "update_users"
  delete "/delete/:id" => "superadmin#destroy_user", as: "destroy_user"
  get "/update/:id" => "superadmin#edit_user", as: "edit_user"
  patch "/update/:id" => "superadmin#confirm_edit", as: "superadmin_edit_user"

  # Moderator
  get "/moderator-panel" => "moderator#index", as: "moderator_panel"
  get "/unverified_listings" => "moderator#unverified_listings", as: "unverified_listings"
  post "/unverified_listings/:id/verify/:verified" => "moderator#verify"
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
