Rails.application.routes.draw do

  scope :my, module: 'hr/my', as: :my do
    root 'home#index'

    controller :home do
      get :index
    end
    resources :orders, only: [:new, :create] do
      get :dinners, on: :collection
      patch :confirm, on: :member
      delete :remove, on: :member
    end

    resources :dinners, only: [:index, :show] do
      patch :order, on: :member
    end
  end



end
