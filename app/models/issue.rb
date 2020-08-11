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

  def readable_status
    case status
    when 'not-started'
      'Not started'
    when 'in-progress'
      'In progress'
    when 'complete'
      'Complete'
    end
  end

  def complete?
    status == 'complete'
  end

  def in_progress?
    status == 'in-progress'
  end

  def not_started?
    status == 'not-started'
  end
end
