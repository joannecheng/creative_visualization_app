require 'spec_helper'
require 'json'

describe Issue do

  describe '.import_issue' do
    context 'normal import' do
      it 'creates new issue, user, and label in database' do
        Issue.import_issue(sample_issue_response)
        issue = Issue.first

        expect(issue.url).to eq 'https://api.github.com/repos/octocat/Hello-World/issues/1347'
        expect(issue.state).to eq "open"
        expect(issue.title).to eq 'Found a bug'
        expect(issue.body).to eq "I'm having a problem with this."
        expect(issue.assignee.class).to eq Assignee
        expect(issue.assignee.login).to eq 'octocat'
        expect(issue.labels.first.name).to eq 'bug'
        expect(issue.github_created_at).to eq Date.parse('2011-04-22T13:33:48Z')
        expect(issue.github_closed_at).to be_nil
        expect(issue.pull_request.url).to eq "https://github.com/octocat/Hello-World/pull/1347"
      end
    end

    context 'issue already exists' do
      it 'updates if issue already exists' do
        sample_issue = sample_issue_response
        Issue.import_issue(sample_issue)
        sample_issue[:state] = 'closed'
        Issue.import_issue(sample_issue)

        issue = Issue.first

        expect(issue.state).to eq 'closed'
      end
    end
  end

  def sample_issue_response
    JSON.parse File.open("spec/fixtures/sample_issue_response.json").read
  end

  describe '#pull_request?' do
    it 'returns true if there is a pull request object' do
      Issue.import_issue(sample_issue_response)
      issue = Issue.first

      expect(issue.pull_request?).to be_true
    end
  end
end
