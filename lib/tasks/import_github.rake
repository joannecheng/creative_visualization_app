require 'faraday'
require 'json'

desc 'import github'
namespace :import do
  task github: :environment do
    per_page = 100
    url = 'https://api.github.com/repos/rails/rails/issues'

    (1..1).each do |page|
      response = JSON.parse(
        Faraday.get("#{url}?page=#{page}&per_page=#{per_page}").body
      )
      response.each do |issue_data|
        Issue.import_issue HashWithIndifferentAccess.new(issue_data)
      end
    end
  end
end
