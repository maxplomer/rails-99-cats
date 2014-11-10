NinetyNineCats::Application.routes.draw do
  resources :cats, only: [
    :index,
    :show,
    :create,
    :new,
    :edit,
    :update
    ]

  resources :cat_requests, only: [
    :index,
    :show,
    :create,
    :new,
    :edit,
    :update
  ] do
      patch 'approve'
      patch 'deny'
    end

  resources :users, :only => [:create, :new, :show]
  resource :session, :only => [:create, :destroy, :new]

  root :to => "users#show"

end
