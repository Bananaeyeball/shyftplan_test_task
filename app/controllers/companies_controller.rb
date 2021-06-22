# frozen_string_literal: true

class CompaniesController < ApplicationController
  def index
    @resources = action_service.call
    render_for_index(@resources)
  end

  def create
    status = action_service.call
    render_status status
  end

  def update
    status = action_service.call
    render_status status
  end

  def destroy
    status = action_service.call
    render_status status
  end
end
