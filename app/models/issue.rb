class Issue < ActiveRecord::Base
  has_one :assignee
  has_one :pull_request
  has_many :labels

  validates :url, uniqueness: true

  def self.closed_issues
    Issue.where(github_closed_at: nil)
  end

  def self.open_issues
    Issue.where.not(github_closed_at: nil)
  end

  def self.timeline_json
    pull_request_issue_ids = PullRequest.all.map(&:issue_id)
    Issue.all.map do |issue|
      {
        created_at: issue.github_created_at,
        closed_at: issue.github_closed_at,
        is_pull_request: pull_request_issue_ids.include?(issue.id)
      }
    end.to_json
  end

  def self.new_issues_by_day
    created_at_dates = Issue.all.map(&:github_created_at)
    dates = Range.new(created_at_dates.min, created_at_dates.max)
    {
      x_axis: dates.to_a,
      data: dates.map { |date| Issue.where(github_created_at: date).count }
    }.to_json
  end

  def self.import_issue(content)
    content = HashWithIndifferentAccess.new(content)
    issue = Issue.find_or_create_by(url: content[:url])
    issue.state = content[:state]
    issue.title = content[:title]
    issue.body = content[:body]
    issue.assignee = Assignee.find_or_create_by(login: content[:user][:login])
    issue.pull_request = PullRequest.find_or_create_by(url: content[:pull_request][:html_url])

    labels = content[:labels].map do |label|
      Label.find_or_create_by(name: label[:name])
    end

    issue.labels = labels
    issue.github_created_at = content[:created_at]
    issue.github_closed_at = content[:closed_at]

    issue.save!
  end

  def pull_request?
    !pull_request.nil?
  end
end
