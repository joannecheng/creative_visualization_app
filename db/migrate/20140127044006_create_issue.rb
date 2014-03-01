class CreateIssue < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :url
      t.string :state
      t.string :title
      t.text :body
      t.date :github_created_at
      t.date :github_closed_at
      t.integer :github_issue_id
      t.integer :number_comments

      t.belongs_to :pull_request
      t.belongs_to :repo
    end

    create_table :repos do |t|
      t.string :url
    end

    create_table :assignees do |t|
      t.belongs_to :issue
      t.string :login
    end

    create_table :labels do |t|
      t.belongs_to :issue
      t.string :name
    end

    create_table :pull_requests do |t|
      t.string :url
    end

    add_index :issues, :pull_request_id
  end
end
