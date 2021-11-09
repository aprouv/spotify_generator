Rails.application.routes.draw do
  resources :playlists, only: [:show, :new, :create]
end
