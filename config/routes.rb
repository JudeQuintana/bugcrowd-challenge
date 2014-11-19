Rails.application.routes.draw do
  post '/tag', to: 'entities#create', defaults: {format: :json}
  get '/tags/:entity_type/:entity_id', to: 'entities#show', defaults: {format: :json}
  delete '/tags/:entity_type/:entity_id', to: 'entities#destroy',defaults: {format: :json}

  get '/stats', to: 'stats#index', defaults: {format: :json}
  get '/stats/:entity_type/:entity_id', to: 'stats#show', defaults: {format: :json}
end
