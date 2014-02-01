class Issue < ActiveRecord::Base
  has_one :assignee
  has_one :pull_request
  has_many :labels

  validates :url, uniqueness: true

  def self.import_issue(content)
    content = HashWithIndifferentAccess.new(content)
    issue = Issue.first_or_create(url: content[:url])
    issue.state = content[:state]
    issue.title = content[:title]
    issue.body = content[:body]
    issue.assignee = Assignee.first_or_create(login: content[:user][:login])
    issue.pull_request = PullRequest.first_or_create(url: content[:pull_request][:html_url])

    labels = content[:labels].map do |label|
      Label.first_or_create(name: label[:name])
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
