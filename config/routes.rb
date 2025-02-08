Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'movies#index'

  # Movies search
  get 'movies/search', to: 'movies#search', as: 'search_movies'

  # Movie resources with nested routes for comments and favorites
  resources :movies, only: %i[index show new create edit update destroy] do
    # Favorite/unfavorite actions
    collection do
      post 'favorite'
      get 'favorites'
    end

    member do
      delete 'unfavorite'
      post 'add_comment'
      delete 'remove_comment'
      get 'edit_comment/:comment_id', to: 'movies#edit_comment', as: 'edit_comment'
      patch 'update_comment/:comment_id', to: 'movies#update_comment', as: 'update_comment'
    end
  end
end
