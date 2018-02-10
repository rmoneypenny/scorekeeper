Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#home'
  get 'register', to: 'admin#new'
  post 'register', to: 'admin#create'
  post 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
  get 'settings', to: 'dashboard#settings'
  get 'settings/password', to: 'admin#changePassword'
  get 'settings/name', to: 'admin#changeName'
  get 'settings/players', to: 'players#show'
  get 'settings/groups', to: 'groups#show'
  patch 'settings/password', to: 'admin#updatePassword'
end
