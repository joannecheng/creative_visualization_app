require 'faraday'
require 'json'

desc 'import github'
namespace :import do
  task github: :environment do
    token = ENV['GITHUB_ACCESS_TOKEN']
    (1..1).each do |page|
      response = JSON.parse(
        Faraday.get(format_url(page, token)).body
      )
      response.each do |issue_data|
        Issue.import_issue HashWithIndifferentAccess.new(issue_data)
      end
    end
  end

  def format_url(page_number, token)
    per_page = 100
    url = 'https://api.github.com/repos/rails/rails/issues'
    "#{url}?page=#{page_number}&per_page=#{per_page}&access_token=#{token}"
  end
end
