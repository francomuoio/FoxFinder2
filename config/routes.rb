Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :companies, path: 'company', controllers: {
   confirmations: 'companies/confirmations',
   registrations: 'companies/registrations',
   passwords: 'companies/passwords',
   sessions: 'companies/sessions',
   unlocks: 'companies/unlocks'
 }

resources :companies do
    resources :properties
    resources :negociators
end

devise_for :users, path: 'user', controllers: {
 confirmations: 'users/confirmations',
 registrations: 'users/registrations',
 passwords: 'users/passwords',
 sessions: 'users/sessions',
 unlocks: 'users/unlocks'
}


  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
