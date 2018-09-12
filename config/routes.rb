Rails.application.routes.draw do

  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :update] do
    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]
  end

  get 'welcome/index'

  root 'welcome#index'

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/edit_user" => "users#edit", as: "edit_user"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Google OAuth Route
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
