class PullRequest < ActiveRecord::Base
  validates :url, uniqueness: true
  has_one :issue

end
