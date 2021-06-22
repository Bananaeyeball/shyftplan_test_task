# frozen_string_literal: true

class EmployeesController < ApplicationController
  def index
    @resources = action_service.call
    render_for_index(@resources)
  end

  def create
    status = action_service.call
    render_status status
  end

  def destroy
    status = action_service.call
    render_status status
  end
end
