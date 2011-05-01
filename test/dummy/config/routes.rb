Dummy::Application.routes.draw do
  resources :authors

  resources :articles

  root :to => "articles#index"

end
