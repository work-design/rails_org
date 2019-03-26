Rails.application.routes.draw do

  scope module: 'org' do
    resources :members, only: [:index, :show] do
      get :search, on: :collection
    end
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

  scope :panel, module: 'org/panel', as: 'panel' do
    root to: 'organ#show'

    resource :organ do
      get :login
    end
    resources :organ_grants
    resources :offices do
      resources :rooms
    end
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
    resources :members do
      get :departments, on: :collection
      get :leaders, on: :collection
      patch :sync_all, on: :collection
      get :profile, on: :member
      get :token, on: :member
    end
    resources :supports do
      get :departments, on: :collection
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

  scope :admin, module: 'org/admin', as: :admin do
    resources :organs do
      patch :mock, on: :member
    end
  end

end
