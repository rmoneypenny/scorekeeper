Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home', to: 'dashboard#home'
  get 'register', to: 'admin#new'
  post 'register', to: 'admin#create'
  post 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
end
