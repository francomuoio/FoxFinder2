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
resources :sieges
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

get 'mentions', to: 'pages#mentions'
get 'cgu', to: 'pages#cgu'
get 'pro', to: 'pages#pro'
get 'tableau', to: 'biens#tables'
get 'stat', to: 'biens#graph'
get 'profile', to: 'users#public_show'
get 'sansbien', to: 'pages#sansbien'
get 'recherche_adresse', to: 'pages#recherche_adresse'
get 'recherche_type', to: 'pages#recherche_type'
get 'recherche_pieces', to: 'pages#recherche_pieces'
get 'recherche_info', to: 'pages#recherche_info'
get 'carte_ventes', to: 'pages#carte_ventes'
get 'all_biens', to: 'biens#all_biens'
get 'blog', to: 'pages#menublog'
get 'commentvendre', to: 'pages#article1'
get 'article2', to: 'pages#article2'
get 'maisonsfrance', to: 'pages#article3'
get 'delaisdeventes', to: 'pages#article4'
get 'maisondumonde', to: 'pages#article5'
get 'article6', to: 'pages#article6'
get 'article7', to: 'pages#article7'
get 'article8', to: 'pages#article8'
get 'article9', to: 'pages#article9'
get 'article10', to: 'pages#article10'
get 'article11', to: 'pages#article11'
get 'article12', to: 'pages#article12'
get 'article13', to: 'pages#article13'
root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
