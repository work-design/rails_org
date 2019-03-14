Rails.application.routes.draw do

  scope module: 'org' do
    resources :members, only: [:index, :show]
  end

  scope :my, module: 'org/my', as: 'my' do
    resources :members
    resources :organs do
      patch :login, on: :member
    end
    resources :tutorials do
      get :tutorings, on: :collection
      get :perform, on: :member
    end
    resource :resign
    resources :job_transfers do
      get :departments, on: :collection
    end
    resources :recruitment_plans do
      patch :comment, on: :member
      patch :handle, on: :member
      patch :repropose, on: :member
      patch :confirm, on: :member
      get :my, on: :collection
    end
    resources :journal_transfers do
    end
    resources :documents
  end

  scope :admin, module: 'org/admin', as: 'admin' do
    root to: 'home#index'

    resources :managers do
      get 'user' => :edit_user, on: :member
      patch 'user' => :update_user, on: :member
    end
    resources :sm_settings

    resources :organs do
      patch :mock, on: :member
      resources :organ_tokens, only: [:index, :new, :create, :destroy], as: :tokens
    end

    resources :offices
    resources :departments do
      get :supports, on: :collection
      get :parents, on: :collection
      get :my, on: :collection
      get :search, on: :collection
      get :filter, on: :collection
      get :need, on: :member
      resources :job_descriptions
      resources :department_journals, as: :journals
    end
    resources :job_titles
    resources :supports do
      get :departments, on: :collection
    end
    resources :members do
      get :departments, on: :collection
      get :leaders, on: :collection
      patch :sync_all, on: :collection
      get 'user' => :edit_user, on: :member
      patch 'user' => :update_user, on: :member
      get :profile, on: :member
      get :edit_profile, on: :member
      patch 'profile' => :update_profile, on: :member
      patch :sync_one, on: :member
    end

    resources :tutorials do
      get :my, on: :collection
    end

    resources :job_transfers do
      patch :trigger, on: :member
      get :my, on: :collection
    end
    resources :resigns do
      get :my, on: :collection
      get :charts, on: :collection
    end
    resources :resign_reasons do
      get :parents, on: :collection
    end
  end

end
