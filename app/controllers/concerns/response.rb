# frozen_string_literal: true

module Response
  def json_response(messages, is_success, data, status, errors = [])
    render json: {
      messages: messages,
      is_success: is_success,
      data: data,
      errors: errors
    }, status: status
  end
end
