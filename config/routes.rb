Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show, :index, :create] do
        post "/shots", to: "games/shots#create"
        post "/ships", to: 'games/ships#create'
      end
    end
  end

  root 'welcome#index'
  get "/register", :to => 'users#new'
  post "/register", :to => 'users#create'
  get "/dashboard", :to => 'dashboard#index'
  get "/games/new", :to => 'games#new', as: 'new_game'
  post "/games/new", :to => 'games#create'
  get "/games/:id", :to => 'games#show', as: 'game'
  get "/activation/:id", :to => 'activation#update', as: 'activation'
  get "/login", :to => 'sessions#new', as: 'login'
  post "/login", :to => 'sessions#create'
  get "/logout", :to => 'sessions#destroy'
end
