json.array! @issues do |issue|
  json.age_in_days issue.age_in_days
  json.number_comments issue.number_comments
  json.title issue.title
  json.is_pull_request issue.pull_request?
  json.state issue.state
end
