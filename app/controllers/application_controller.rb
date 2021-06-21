# frozen_string_literal: true
class ApplicationController < ActionController::API
  def render_for_index(resources)
    render_with_serializerr(resources, action: :index)
  end

  private

  def render_with_serializer(resources, options = {})
    json_hash = serializer_class.new(resources, options).serializable_hash
    render json: json_hash, status: options[:status]
  end

  def serializer_class
    @serializer_class ||= "#{controller_path.classify}Serializer".constantize
  end
end
