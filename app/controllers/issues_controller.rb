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
    render json: by_count.to_json
  end

  def timeline
    render json: Issue.timeline_json
  end

  def new_issues_by_day

    render json: Issue.new_issues_by_day
  end

  def by_date

  end
end
