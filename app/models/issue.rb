class Issue < ActiveRecord::Base
  has_one :assignee
  has_many :labels

  def self.import_issue(content)
    issue = Issue.new()
    issue.url = content[:url]
    issue.state = content[:state]
    issue.title = content[:title]
    issue.body = content[:body]
    issue.assignee = Assignee.first_or_create(login: content[:user][:login])

    labels = content[:labels].map do |label|
      Label.first_or_create(name: label[:name])
    end

    issue.labels = labels
    issue.github_created_at = content[:created_at]
    issue.github_closed_at = content[:closed_at]

    issue.save!
  end
end
