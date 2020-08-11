# frozen_string_literal: true

class AddReferencesToIssues < ActiveRecord::Migration[6.0]
  def up
    add_column :issues, :reporter_id, :integer
    add_column :issues, :assignee_id, :integer
  end

  def down
    remove_column :issues, :reporter_id, :integer
    remove_column :issues, :assignee_id, :integer
  end
end
