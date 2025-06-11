Rails.application.routes.draw do
  resources :panel
  resources :tickets
  resources :incidents
  resources :multa
  resources :wtransactions
  resources :cards
  resources :wallets
  resources :licenses
  resources :rentals
  resources :vehicles
  resources :about
  resources :profile
  resources :locations, only: [:create]

  
  authenticate :user, lambda { |u| u.admin_role? } do
    mount Motor::Admin => '/motor_admin'
  end

  devise_for :users, controllers: { registrations: 'user/registrations' }
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
  end  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Main routes
  root 'main#index'

  #Vehicle routes
  get 'vehicles/:id/publish', to: 'vehicles#publish', as: 'publish'
  
  get 'vehicles/:id/block', to: 'vehicles#block', as: 'block'

  #License routes
  get 'licenses/:id/authorize', to: 'licenses#authorize', as: 'authorize_license'

  get 'licenses/:id/decline', to: 'licenses#decline', as: 'decline_license'

  #Rental routes
  #define a route to create a new rental receiving the vehicle id from the url
  get 'vehicles/:id/rent', to: 'rentals#new', as: 'rent'
  
  #define a route to create a incident receiving the rental id from the url
  get 'rentals/:id/incident', to: 'incidents#new', as: 'incident2'
  
  #define a route to overlimit a rental receiving the rental id from the url
  get'rentals/:id/overlimit', to: 'rentals#overlimit', as: 'overlimit'

  #define a route to finish a rental receiving the rental id from the url
  get 'rentals/:id/finish', to: 'rentals#finish', as: 'finish_rental'

  #deine a route for show2 method
  get 'rentals/show2', to: 'rentals#show2', as: 'show2'

  #define a route to create a multum receiving the user id from the url
  get 'users/:id/multum', to: 'multa#new', as: 'multum2'  

  #define a post route to extend hours a rental receiving the rental id from the url 
  get 'rentals/:id/extend_hours', to: 'rentals#extend_hours', as: 'extend_hours'

  #define a route to show method of rental with the id of vehicle
  get 'vehicles/:id/rentals', to: 'rentals#show', as: 'rental_vehicle'

  #Wtransaction routes
  
  get 'cards/:id/wtransaction', to: 'wtransactions#new', as: 'wtransactionc'


  #define a route to update_role_supervisor with the user id from the url
  get 'users/:id/update_role_supervisor', to: 'panel#update_role_supervisor', as: 'update_role_supervisor'
  get 'users/:id/update_role_admin', to: 'panel#update_role_admin', as: 'update_role_admin'
  get 'users/:id/update_role_user', to: 'panel#update_role_user', as: 'update_role_user'

  #define a route to soft_delete with the user id from the url
  get 'users/:id/soft_delete', to: 'panel#soft_delete', as: 'soft_delete'

  #define a route to assign an incident to a user receiving the user id from the url
  get 'incidents/:id/assign_incident', to: 'incidents#asignar', as: 'assign_incident'

  #define a route to report index
  get 'report/index', to: 'report#index', as: 'report_index'

  #Ticket custom routes

  #define a route to show method format pdf
  get 'tickets/:id/comprobante.pdf', to: 'tickets#show', as: 'comprobante'


end
