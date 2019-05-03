Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :participants
  resources :game_library do
      get :get_gameinfo, on: :member
    end
  resources :game_logs
  resources :winner_circle

end