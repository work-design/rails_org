Rails.application.routes.draw do

  scope module: 'org' do
    resources :members, only: [:index, :show] do
      collection do
        get :search
      end
    end
    resources :organs, only: [:index, :show] do
      collection do
        get :form_search
      end
    end
  end

  scope :my, module: 'org/my', as: :my do
    controller :home do
      get :index
    end
    resource :member, except: [:new, :create]
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

  scope :my, module: 'org/board', as: :my do
    resources :organs
    resources :members, only: [:new, :create] do
      member do
        patch :login_admin
        patch :login_my
      end
    end
  end

  scope :our, module: 'org/our', as: :our do
    root 'organs#show'
    resource :organ
  end

  scope :panel, module: 'org/panel', as: :panel do
    resources :organs
  end

  scope :admin, module: 'org/admin', as: :admin do
    resources :organs do
      get :all, on: :collection
    end
    resources :departments do
      collection do
        get :supports
        get :parents
        get :my
        get :search
        get :filter
      end
      member do
        get :need
      end
      resources :job_titles do
        collection do
          post 'department' => :create_department
        end
        member do
          patch :move_lower
          patch :move_higher
          patch :reorder
        end
      end
      resources :job_descriptions
    end
    resources :super_job_titles do
      member do
        patch :move_lower
        patch :move_higher
        patch :reorder
      end
    end
    resources :members do
      collection do
        get :options
        get :departments
        get :leaders
        patch :sync_all
        get 'add_item/:item' => :add_item, as: :add_item
        get 'remove_item/:item' => :remove_item, as: :remove_item
      end
      member do
        get :profile
        get :token
        patch :mock
      end
      resources :member_departments do
        collection do
          get :options
        end
        member do
          get 'options' => :member_options
        end
      end
      resources :organ_grants
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
    scope ':record_class/:record_column' do
      resources :department_grants
    end
  end

end
