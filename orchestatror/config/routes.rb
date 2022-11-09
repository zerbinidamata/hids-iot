Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :rules
  resources :actions
  resources :test_cases
  resources :scripts
  resources :devices
  resources :device_groups
  resources :external_agents


  post 'send_rules', to: 'device_groups#send_rules'
  post 'deliver_rule_to_group', to: 'rules#deliver_rule_to_group'

end

Rails.application.routes.default_url_options[:host] = 'localhost:3000'
