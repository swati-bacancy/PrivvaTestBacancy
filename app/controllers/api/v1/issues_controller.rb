# frozen_string_literal: true

class Api::V1::IssuesController < ApplicationController
  before_action :authenticate_with_token!
  before_action :set_issue, only: %i[show edit update destroy]

  def index
    @issues = fetch_department
    # @issues = Issue.page(params[:page]).per(params[:per_page])
    json_response 'Index issue successfully', true, { issues: @issues }, :ok
  end

  def fetch_department
    search_string = []
    columns.map { |term| search_string << "#{term} ilike :search" }
    issues = Issue.joins('LEFT OUTER JOIN users ON users.id = issues.reporter_id LEFT OUTER JOIN users assignees_issues ON assignees_issues.id = issues.assignee_id')
    if params[:sortable_columns].present?
      sort_direction = params[:sort_direction] || 'desc'
      issues = issues
               .order("#{params[:sortable_columns]} #{sort_direction}")
    end
    # for searching
    if params[:search].present?
      issues = issues.where(
        search_string.join(' or '), search: "%#{params[:search]}%"
      )
    end
    # for pagination
    issues.page(params[:page]).per(params[:per_page])
  end

  def show
    json_response 'Show issue Successfully', true, { issue: @issue }, :ok
  end

  def new
    @issue = Issue.new
    json_response 'new issue', true, { issue: @issue }, :ok
  end

  def edit; end

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      json_response(
        'Issue was successfully created.', true, { issue: @issue }, :ok
      )
    else
      json_response(
        'Something wrong', false, {}, :unprocessable_entity,
        errors: @issue.errors.full_messages
      )
    end
  end

  def update
    if @issue.update_attributes(issue_params)
      json_response(
        'Issue was successfully updated.', true, { issue: @issue }, :ok
      )
    else
      json_response(
        'Issue was not updated.', false, {}, :unprocessable_entity,
        errors: @issue.errors.full_messages
      )
    end
  end

  def destroy
    @issue.destroy
    json_response 'Issue was successfully destroyed.', true, {}, :no_content
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:name, :description, :status, :project_id)
  end

  def columns
    [
      'issues.description',
      'users.name'
    ]
  end
end
