class GithubImporter

  def import(issues_json)
    issues_json.each do |issue|
      Issue.import(issue)
    end
  end
end
