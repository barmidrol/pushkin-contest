PushkinContest::Application.routes.draw do

  root 'rating#index'

  resources :users, path: '/registration', only: [:create] do
    collection do
      get '/', to: 'users#new'
    end
  end

  resources :rating, only: [:index]

  post 'quiz', to: 'quiz#answer'
  get 'documentation', to: 'documentation#index'

end
