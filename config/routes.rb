Rails.application.routes.draw do
  get 'pages/home'
  root to: "pages#home"
  resources :playlists, only: [:index, :show, :new, :create, :destroy]
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }, skip: [:session]
  as :user do
    delete "/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
end
