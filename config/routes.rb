Rails.application.routes.draw do
  get '/weather/:city' => 'api#weather', defaults: {city: 'on-143_e', format: :json}
end
