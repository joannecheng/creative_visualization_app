CreativeVisualizationApp::Application.routes.draw do
  resources :issues, only: [:index]

  get 'issues/by_count', to: 'issues#by_count', as: 'issues_by_count'
  get 'issues/new_issues_by_day', to: 'issues#new_issues_by_day', as: 'issues_new_issues_by_day'

  get 'issues/timeline', to: 'issues#timeline'
  get 'issues/issues_only_timeline', to: 'issues#issues_only_timeline'
  get 'issues/pull_requests_only_timeline', to: 'issues#pull_requests_only_timeline'

end
