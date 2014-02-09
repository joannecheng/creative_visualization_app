CreativeVisualizationApp::Application.routes.draw do
  resources :issues, only: [:index]
  get 'issues/by_count', to: 'issues#by_count', as: 'issues_by_count'
  get 'issues/timeline', to: 'issues#timeline', as: 'issues_timeline'
  get 'issues/new_issues_by_day', to: 'issues#new_issues_by_day', as: 'issues_new_issues_by_day'

end
