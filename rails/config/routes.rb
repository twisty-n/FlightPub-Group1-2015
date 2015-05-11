Rails.application.routes.draw do

  resources :urails

  # OUR API ENPOINTS ===========================================================================
  namespace :api do

    resources :api_keys

    resources :flights

    # Define the API routes for the user. 
    # Provides endpoints for CRUD, but not the normal editing pages
    # We also have a reactivate route that does our soft-delete reactivating
    resources :users , except: [:new, :edit] do 
      post 'reactivate'
    end

    post 'session' => 'session#create'

  end

  # END API ENDPOINTS ===========================================================================

  root 'static_pages#home'
  get 'signup'  => 'users#new'

  resources :users do
    member do
      post 'reactivate'
    end
  end

  # RESTful User Sessions

  # TODO: make some API versions of this so that we can get the same functionality
  get 'login' =>'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'logout' => 'sessions#destroy'    # ot quite restful, but will work

  get 'auth/:provider/callback', to: 'sessions#create_oa'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'


end
