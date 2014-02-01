class PullRequest < ActiveRecord::Base
  validates :url, uniqueness: true

end
