Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#home'
  get 'register', to: 'admin#new'
  post 'register', to: 'admin#create'
  
  post 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
  
  get 'settings', to: 'dashboard#settings'
  
  get 'settings/password', to: 'admin#changePassword'
  patch 'settings/password', to: 'admin#updatePassword'
  get 'settings/name', to: 'admin#changeName'
  patch 'settings/name', to: 'admin#updateName'
  
  get 'settings/players', to: 'players#show'
  post 'settings/players', to: 'players#create'
  patch 'settings/players', to: 'players#update'

  get 'settings/groups', to: 'groups#show'
  post 'settings/groups', to: 'groups#create'
  delete 'settings/groups', to: 'groups#delete'
  patch 'settings/groups', to: 'groups#update'
  
  post 'games/setup', to: 'game#setup'

  get 'seven_wonders', to: 'seven_wonders#show'
  post 'seven_wonders', to: 'seven_wonders#create'
  get 'seven_wonders/stats', to: 'seven_wonders#stats'

  get 'power_grid', to: 'power_grids#show'
  

end
