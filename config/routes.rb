Rails.application.routes.draw do

  scope module: 'org' do
    resources :members, only: [:index, :show] do
      get :search, on: :collection
    end
  end

  scope :my, module: 'org/my', as: 'my' do
    resources :members do
      patch :login, on: :member
      resources :organs
    end
    resources :documents
  end
  
  scope :my, module: 'org/member', as: 'my' do
    resources :departments
    resources :tutorials do
      get :tutorings, on: :collection
      get :perform, on: :member
    end
    resource :resign
    resources :job_transfers do
      get :departments, on: :collection
    end
  end

  scope :admin, module: 'org/admin', as: 'admin' do
    resources :organs do
      get :current, on: :collection
      patch :mock, on: :member
      resources :rooms
    end
    resources :organ_grants
    resources :departments do
      collection do
        get :supports
        get :parents
        get :my
        get :search
        get :filter
      end
      get :need, on: :member
      resources :job_descriptions
    end
    resources :job_titles do
      member do
        patch :move_lower
        patch :move_higher
      end
    end
    resources :members do
      collection do
        get :departments
        get :leaders
        patch :sync_all
        get 'add_item/:item' => :add_item, as: :add_item
        get 'remove_item/:item' => :remove_item, as: :remove_item
      end
      member do
        get :profile
        get :token
      end
      resources :member_departments do
        get :options, on: :collection
        get 'options' => :member_options, on: :member
      end
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
    resources :organ_handles
    resources :department_grants, only: [:index]
    resources :organ_handles, only: [] do
      resources :department_grants, except: [:index]
    end
  end

end
