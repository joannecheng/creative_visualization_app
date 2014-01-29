require 'spec_helper'

describe Issue do

  describe '.import_issue' do
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
    end
  end

  def sample_issue_response
    {
      url: "https://api.github.com/repos/octocat/Hello-World/issues/1347",
      html_url: "https://github.com/octocat/Hello-World/issues/1347",
      number: 1347,
      state: "open",
      title: "Found a bug",
      body: "I'm having a problem with this.",
      user: {
        login: "octocat",
        id: 1,
        avatar_url: "https://github.com/images/error/octocat_happy.gif",
        gravatar_id: "somehexcode",
        url: "https://api.github.com/users/octocat",
        html_url: "https://github.com/octocat",
        followers_url: "https://api.github.com/users/octocat/followers",
        following_url: "https://api.github.com/users/octocat/following{/other_user}",
        gists_url: "https://api.github.com/users/octocat/gists{/gist_id}",
        starred_url: "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        subscriptions_url: "https://api.github.com/users/octocat/subscriptions",
        organizations_url: "https://api.github.com/users/octocat/orgs",
        repos_url: "https://api.github.com/users/octocat/repos",
        events_url: "https://api.github.com/users/octocat/events{/privacy}",
        received_events_url: "https://api.github.com/users/octocat/received_events",
        type: "User",
        site_admin: false
      },
      labels: [
        {
          url: "https://api.github.com/repos/octocat/Hello-World/labels/bug",
          name: "bug",
          color: "f29513"
        }
      ],
      assignee: {
        login: "octocat",
        id: 1,
        avatar_url: "https://github.com/images/error/octocat_happy.gif",
        gravatar_id: "somehexcode",
        url: "https://api.github.com/users/octocat",
        html_url: "https://github.com/octocat",
        followers_url: "https://api.github.com/users/octocat/followers",
        following_url: "https://api.github.com/users/octocat/following{/other_user}",
        gists_url: "https://api.github.com/users/octocat/gists{/gist_id}",
        starred_url: "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        subscriptions_url: "https://api.github.com/users/octocat/subscriptions",
        organizations_url: "https://api.github.com/users/octocat/orgs",
        repos_url: "https://api.github.com/users/octocat/repos",
        events_url: "https://api.github.com/users/octocat/events{/privacy}",
        received_events_url: "https://api.github.com/users/octocat/received_events",
        type: "User",
        site_admin: false
      },
      milestone: {
        url: "https://api.github.com/repos/octocat/Hello-World/milestones/1",
        number: 1,
        state: "open",
        title: "v1.0",
        description: "",
        creator: {
          login: "octocat",
          id: 1,
          avatar_url: "https://github.com/images/error/octocat_happy.gif",
          gravatar_id: "somehexcode",
          url: "https://api.github.com/users/octocat",
          html_url: "https://github.com/octocat",
          followers_url: "https://api.github.com/users/octocat/followers",
          following_url: "https://api.github.com/users/octocat/following{/other_user}",
          gists_url: "https://api.github.com/users/octocat/gists{/gist_id}",
          starred_url: "https://api.github.com/users/octocat/starred{/owner}{/repo}",
          subscriptions_url: "https://api.github.com/users/octocat/subscriptions",
          organizations_url: "https://api.github.com/users/octocat/orgs",
          repos_url: "https://api.github.com/users/octocat/repos",
          events_url: "https://api.github.com/users/octocat/events{/privacy}",
          received_events_url: "https://api.github.com/users/octocat/received_events",
          type: "User",
          site_admin: false
        },
        open_issues: 4,
        closed_issues: 8,
        created_at: "2011-04-10T20:09:31Z",
        due_on: nil
      },
      comments: 0,
      pull_request: {
        html_url: "https://github.com/octocat/Hello-World/pull/1347",
        diff_url: "https://github.com/octocat/Hello-World/pull/1347.diff",
        patch_url: "https://github.com/octocat/Hello-World/pull/1347.patch"
      },
      closed_at: nil,
      created_at: "2011-04-22T13:33:48Z",
      updated_at: "2011-04-22T13:33:48Z"
    }
  end
end
