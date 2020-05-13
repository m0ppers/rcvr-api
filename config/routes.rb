Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :owners,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' },
             controllers: { sessions: 'sessions', registrations: 'registrations' }

  resources :tickets, only: %i[create update]
  get 'risk-feed', to: 'tickets#risk_feed'

  namespace :owners, path: '' do
    resources :companies, only: %i[index create update show] do
      resources :areas, only: %i[index create update show], shallow: true
    end
    resource :owner, only: :update
  end
end
