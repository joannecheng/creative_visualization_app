FactoryGirl.define do
  factory :issue do
    sequence(:url) { |n| "http://github.com/repo/#{n}" }
    sequence(:github_issue_id) { |n| n }

    github_created_at Date.yesterday
    title "Github issue"

    trait :closed do
    end

    trait :open do
      github_closed_at Date.today
    end

  end

end

