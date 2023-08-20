Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :games, only: %i(index new create show) do
    member do 
      post '/', action: :join, as: :join
    end
  end
  root "games#index"
end
