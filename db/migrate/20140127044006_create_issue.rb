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
    end

    create_table :assignees do |t|
      t.belongs_to :issue
      t.string :login
    end

    create_table :labels do |t|
      t.belongs_to :issue
      t.string :name
    end
  end
end
