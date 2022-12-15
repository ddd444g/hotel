Rails.application.routes.draw do

  get 'bookings/index'
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
 
  get "home" => "home#top"

  resources :users
  resources :rooms
  resources :bookings
  root "home#top"
end
