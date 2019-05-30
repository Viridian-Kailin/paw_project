Rails.application.routes.draw do
  controller :paw_staff do
    get 'staff' => :index
  end
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :users
  root 'welcome#index'
  get 'participants/total', to: 'participants#show'
  get 'game_logs/total', to: 'game_logs#show'
  get 'paw_staff/total', to: 'paw_staff#show'
  get 'welcome/index'
  get 'check_entry/:participants', to: 'game_logs#need_reg'
  get 'list_game/:id', to: 'game_library#get_gameinfo'
  get 'list_member/:badge', to: 'game_library#get_memberinfo'
  get 'show_winners', to: 'winner_circle#show_winners'
  get 'redraw', to: 'winner_circle#redraw_winner'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Be careful about route placement, and restart server when adding routes
  resources :participants
  resources :game_library
  resources :game_logs
  resources :winner_circle
  resources :paw_staff
  resources :inventory
  resources :events
  resources :schedule
  resources :rules
  resources :con_staff

end