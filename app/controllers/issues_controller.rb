class IssuesController < ApplicationController
  def index
  end

  def by_state_count
    by_state_count = [
      {
        name: 'closed',
        data: [Issue.closed_issues.count]
      },
      {
        name: 'open',
        data: [Issue.open_issues.count]
      }
    ]
    render json: by_state_count
  end

  def by_type_and_state_count
    closed_issues = Issue.closed_issues
    open_issues = Issue.open_issues

    x_axis_labels = ['Pull Requests', 'Issues']
    data = [
      {
        name: 'closed',
        data: [
          closed_issues.pull_requests.count,
          closed_issues.count - closed_issues.pull_requests.count
        ]
      },
      {
        name: 'open',
        data: [
          open_issues.pull_requests.count,
          open_issues.count - open_issues.pull_requests.count
        ]
      }
    ]
    render json: { series_data: data, x_axis: x_axis_labels }
  end

  def timeline
    @issues = Issue.all

    render :json, template: 'issues/issues_only_timeline'
  end

  def new_issues_by_day
    if params[:normalized]
      new_issues_by_day = Issue.new_issues_by_day_normalized
    else
      new_issues_by_day = Issue.new_issues_by_day
    end
    render json: new_issues_by_day
  end

  def new_issues_by_day_and_type
    if params[:normalized]
      new_issues_by_day = Issue.new_issues_by_day_normalized
    else
      new_issues_by_day = Issue.new_issues_by_day
    end
    render json: new_issues_by_day
  end

  def issues_only_timeline
    @issues = Issue.where(pull_request_id: nil)

    render :json, template: 'issues/issues_only_timeline'
  end

  def pull_requests_only_timeline
    @issues = Issue.where.not(pull_request_id: nil)

    render :json, template: 'issues/issues_only_timeline'
  end

  def age_and_number_comments
    @issues = Issue.all.order('github_created_at DESC')

    render :json, template: 'issues/age_and_number_comments'
  end
end
