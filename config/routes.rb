Rails.application.routes.draw do
  devise_for :companies, path: 'companies'
  devise_for :users, path: 'users', controllers:
  {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
