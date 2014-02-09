require 'spec_helper'

describe IssuesController do

  describe 'GET by_count' do
    it 'returns json of count' do
      get 'issues/by_count.json'

      expect(response).to eq({ open: 10, closed: 10 }.to_json)
    end
  end

end
