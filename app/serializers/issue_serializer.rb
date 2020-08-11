# frozen_string_literal: true

class IssueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status
end
