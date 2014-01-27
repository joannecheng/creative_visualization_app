class CreateIssue < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :url
      t.string :state
      t.string :title
      t.string :body
      t.date :issue_created_at
      t.date :issue_closed_at
    end
  end
end
