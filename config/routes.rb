Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :exercises, only: [:index, :show]
      resources :routines, only: [:index, :show, :create, :update, :destroy]
      resources :exercise_routines, only: [:index, :create, :destroy]
      resources :users, only: [:create]
      get '/my_routines', to: 'my_routines#index'
      post '/my_routines', to: 'my_routines#create'
      delete '/my_routines/:id', to: 'my_routines#destroy'
    end
  end
end
