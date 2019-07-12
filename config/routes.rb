# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Be careful about route placement, and restart server when adding routes
  root 'welcome#index'

  resources :participants
  resources :game_library
  get 'list_game/:id', to: 'game_library#gameinfo'
  get 'list_member/:badge', to: 'game_library#memberinfo'
  resources :game_logs
  get 'check_entry/:badge_id', to: 'game_logs#need_reg'
  resources :winner_circle
  get 'show_winners', to: 'winner_circle#show_winners'
  get 'redraw', to: 'winner_circle#redraw_winner'
  resources :inventories
  resources :events
  resources :schedules
  resources :rules
  resources :paw_staffs, path: 'staff'
  resources :con_staffs
  resources :users

  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
