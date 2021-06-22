# frozen_string_literal: true

module Employees
  class DestroyService
    def initialize(params)
      @params = params
    end

    def call
      Employee.find(@params[:id]).destroy!
      200
    rescue ActiveRecord::RecordNotFound
      404
    end
  end
end
