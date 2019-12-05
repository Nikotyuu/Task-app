Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  get '/tasks', to: 'tasks#new'
  get '/tasks/:id/index', to: 'task#index'
  
  
  get    '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    resources :tasks
  end
end
