class Issue < ActiveRecord::Base
  has_one :assignee
  has_many :labels
  belongs_to :pull_request

  validates :url, uniqueness: true

  def self.closed_issues
    Issue.where(github_closed_at: nil)
  end

  def self.open_issues
    Issue.where.not(github_closed_at: nil)
  end

  def self.new_issues_by_day
    all_issues = Issue.all
    created_at_dates = all_issues.map(&:github_created_at)
    dates = Range.new(created_at_dates.min, created_at_dates.max)

    {
      x_axis: dates.to_a,
      data: dates.map { |date| all_issues.select { |i| i.github_created_at == date }.count }
    }
  end

  def self.import_issue(content)
    content = HashWithIndifferentAccess.new(content)
    issue = Issue.find_or_create_by(url: content[:url])
    issue.state = content[:state]
    issue.title = content[:title]
    issue.body = content[:body]
    issue.assignee = Assignee.find_or_create_by(login: content[:user][:login])
    if content[:pull_request][:html_url]
      issue.pull_request = PullRequest.find_or_create_by(url: content[:pull_request][:html_url])
    end

    labels = content[:labels].map do |label|
      Label.find_or_create_by(name: label[:name])
    end

    issue.labels = labels
    issue.github_created_at = content[:created_at]
    issue.github_closed_at = content[:closed_at]

    issue.save!
  end

  def pull_request?
    !pull_request_id.nil?
  end
end
