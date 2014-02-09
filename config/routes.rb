CreativeVisualizationApp::Application.routes.draw do
  resources :issues, only: [:index]
  get 'issues/by_count', to: 'issues#by_count', as: 'issues_by_count'
  get 'issues/timeline', to: 'issues#timeline', as: 'issues_timeline'

end
