Rails.application.routes.draw do
  get '/campaigns/index', to: 'campaigns#index'
  get '/campaigns/:id', to: 'campaigns#show', as: "campaign"

  root to: 'campaigns#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
