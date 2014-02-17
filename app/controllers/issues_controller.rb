class IssuesController < ApplicationController
  def index
  end

  def by_count
    by_count = [
      {
        name: 'closed',
        data: [Issue.closed_issues.count]
      },
      {
        name: 'open',
        data: [Issue.open_issues.count]
      }
    ]
    render json: by_count
  end

  def timeline
    @issues = Issue.all

    render :json, template: 'issues/issues_only_timeline'
  end

  def new_issues_by_day
    render json: Issue.new_issues_by_day
  end

  def issues_only_timeline
    @issues = Issue.where(pull_request_id: nil)

    render :json, template: 'issues/issues_only_timeline'
  end

  def pull_requests_only_timeline
    @issues = Issue.where.not(pull_request_id: nil)

    render :json, template: 'issues/issues_only_timeline'
  end
end
