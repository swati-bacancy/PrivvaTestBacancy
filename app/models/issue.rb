# frozen_string_literal: true

class Issue < ApplicationRecord
  validates :status, inclusion: { in: %w[not-started in-progress complete] }
  paginates_per 10
  belongs_to :reporter, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  STATUS_OPTIONS = [
    ['Not started', 'not-started'],
    ['In progress', 'in-progress'],
    %w[Complete complete]
  ].freeze
end
