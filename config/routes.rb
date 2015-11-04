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
    post '/ace' => 'ace#apply'
  end
end
