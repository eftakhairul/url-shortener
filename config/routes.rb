Rails.application.routes.draw do

  #Authentication
  devise_for :users

  #ALl Routes related to URL
  resources :urls , only: [:index, :new, :create, :translate]

  #URL Shortener Page
  root :to => 'urls#new'

  #Translation route
  get '/s/:unique_key', :to => 'urls#translate', :as => 'shortener_translate'

end
