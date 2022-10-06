# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'cheapest_direct_sailings', to: 'cheapest_direct_sailings#index'
  get 'cheapest_indirect_sailings', to: 'cheapest_sailings#index'
end
