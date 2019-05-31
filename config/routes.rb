Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Be careful about route placement, and restart server when adding routes

  resources :participants
  resources :game_library
  resources :game_logs
  resources :winner_circle
  resources :inventory
  resources :events
  resources :schedule
  resources :rules
  resources :con_staff
  resources :paw_staff, path: 'staff'
  resources :users

  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  root 'welcome#index'

  get 'welcome/index'
  get 'participants/total', to: 'participants#show'
  get 'game_logs/total', to: 'game_logs#show'
  get 'check_entry/:participants', to: 'game_logs#need_reg'
  get 'list_game/:id', to: 'game_library#get_gameinfo'
  get 'list_member/:badge', to: 'game_library#get_memberinfo'
  get 'show_winners', to: 'winner_circle#show_winners'
  get 'redraw', to: 'winner_circle#redraw_winner'

end