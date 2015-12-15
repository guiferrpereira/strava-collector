Rails.application.routes.draw do
  root 'temporary#index'

  get 'login',            to: 'account#login'
  get 'authorize',        to: 'account#authorize'
end
