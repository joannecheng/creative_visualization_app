CreativeVisualizationApp::Application.routes.draw do
  resources :issues, only: [:index]

  # highcharts resources
  get 'issues/by_state_count', to: 'issues#by_state_count'
  get 'issues/by_type_and_state_count', to: 'issues#by_type_and_state_count'
  get 'issues/new_issues_by_day', to: 'issues#new_issues_by_day', as: 'issues_new_issues_by_day'

  get 'issues/timeline', to: 'issues#timeline'
  get 'issues/issues_only_timeline', to: 'issues#issues_only_timeline'
  get 'issues/pull_requests_only_timeline', to: 'issues#pull_requests_only_timeline'
  get 'issues/age_and_number_comments', to: 'issues#age_and_number_comments'
end
