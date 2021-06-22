# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_for_index(resources, status: 200)
    render_with_serializer(resources, action: :index, status: status)
  end

  private

  def render_with_serializer(resources, options = {})
    json_hash = serializer_class.new(resources, options).serializable_hash
    render json: json_hash, status: options[:status]
  end

  def render_status(status)
    head status
  end

  def serializer_class
    @serializer_class ||= "#{controller_path.classify}Serializer".constantize
  end

  def action_service
    @action_service ||= "#{controller_path}::#{action_name.classify}Service".classify.constantize.new(params)
  end
end
