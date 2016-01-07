Rails.application.routes.draw do
  root 'temporary#index'

  get 'login',              to: 'account#login'
  get 'authorize',          to: 'account#authorize'
  put 'update_activities',  to: 'temporary#update_activities'
  put 'update_stats',       to: 'temporary#update_stats'
  get 'leaderboards',       to: 'temporary#calculate_friends_totals'
end
