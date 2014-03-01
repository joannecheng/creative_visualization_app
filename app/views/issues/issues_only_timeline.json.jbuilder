json.array! @issues do |issue|
  json.created_at issue.github_created_at
  json.closed_at issue.github_closed_at
  json.number_comments issue.number_comments
  json.is_pull_request issue.pull_request?
end
