Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  get 'list_game/:id', to: 'game_library#get_gameinfo'
  get 'check_entry/:participants', to: 'game_logs#need_reg'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Be careful about route placement, and restart server when adding routes
  resources :participants
  resources :game_library
  resources :game_logs
  resources :winner_circle

end