Rails.application.routes.draw do

  namespace :admin do
    root to: '/rails_auth_admin/users#index'

    resources :managers do
      get 'user' => :edit_user, on: :member
      patch 'user' => :update_user, on: :member
    end
    resources :sm_settings
  end

end
