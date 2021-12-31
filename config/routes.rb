Rails.application.routes.draw do
  devise_for :users
  root to: "playlists#index"
  resources :playlists, only: [:index, :show, :new, :create]
end
