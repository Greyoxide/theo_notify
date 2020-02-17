Rails.application.routes.draw do

	root 'assignments#index'

	resources :users
	resources :invitations
	resources :password_resets
	resources :batch_assignments

	resources :people
	resources :assignments
	resources :parts
	resources :meetings

	get   '/signin',   to: 'sessions#new'
	post  '/signin',   to: 'sessions#create'
	get   '/signout',  to: 'sessions#destroy'


end
