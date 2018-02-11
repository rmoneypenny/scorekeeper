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
  get 'settings/groups', to: 'groups#show'
end
