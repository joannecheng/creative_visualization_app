require 'spec_helper'

describe GithubImporter do
  describe '#import' do
    xit 'imports' do
      g = GithubImporter.new

      g.import()

      expect(Issue.all).not_to be_empty
    end
  end

end
