Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :activities do
      get '/' => 'home#index'
      get '/:id' => 'home#show'
      post '/' => 'home#create'

      get '/:id/comments' => 'comments#index'
      post '/:id/comments' => 'comments#create'

      get '/:id/applies' => 'applies#index'
      post '/:id/applies' => 'applies#create'
    end
    #达人开跑
    namespace :runnings do
      post 'captcha' => 'captcha#create'

      post 'users/login' => 'users#login'
      post 'user' => 'users#create'

      get ':phase' => 'home#index'
      post ':phase' => 'home#follow'
      get ':phase/comments' => 'comments#index'
      post ':phase/comments' => 'comments#create'
      post ':phase/comments/:id' => 'comments#like'
    end

    post '/ace' => 'ace#apply'
    post '/nj' => 'nj#apply'
  end
end
