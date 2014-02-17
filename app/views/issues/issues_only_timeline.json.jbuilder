json.array! @issues do |issue|
  json.created_at issue.github_created_at
  json.closed_at issue.github_closed_at
  json.is_pull_request issue.pull_request?
end
