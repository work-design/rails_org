Rails.application.routes.draw do

  namespace :me do
    root 'home#index'
  end

  scope module: 'org', defaults: { business: 'org' } do
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

  scope 'me', module: 'org/me', as: :me, defaults: { business: 'org', namespace: 'me' } do
    resource :member, except: [:new, :create]
    resources :departments
    resources :tutorials do
      collection do
        get :tutorings
      end
      member do
        get :perform
      end
    end
    resource :resign
    resources :job_transfers do
      get :departments, on: :collection
    end
  end

  scope :board, module: 'org/board', as: :board, defaults: { business: 'org', namespace: 'board' } do
    resources :organs
    resources :members, only: [:index, :new, :create] do
      collection do
        get :near
      end
    end
  end

  scope :panel, module: 'org/panel', as: :panel, defaults: { business: 'org', namespace: 'panel' } do
    resources :organs do
      resources :organ_domains
    end
  end

  scope 'admin', module: 'org/admin', as: :admin, defaults: { business: 'org', namespace: 'admin' } do
    root 'home#index' unless has_named_route? 'admin_root'
    controller :home do
      get :index
    end
    resource :current_organ, controller: 'current_organ'
    resources :organs do
      collection do
        get :all
      end
      resources :organ_domains
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
      resources :authorized_tokens
    end
    resources :supports do
      collection do
        get :departments
      end
    end
    resources :tutorials do
      collection do
        get :my
      end
    end
    resources :job_transfers do
      member do
        patch :trigger
      end
      collection do
        get :my
      end
    end
    resources :resigns do
      collection do
        get :my
        get :charts
      end
    end
    resources :resign_reasons do
      collection do
        get :parents
      end
    end
    scope ':record_class/:record_column' do
      resources :department_grants
    end
  end

end
