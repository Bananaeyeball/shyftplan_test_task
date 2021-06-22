# frozen_string_literal: true

module Employees
  class CreateService
    def initialize(params)
      @params = params
    end

    def call
      Employee.new(create_params).save!
      201
    rescue ActiveRecord::RecordInvalid, ActionController::ParameterMissing
      422
    end

    private

    def create_params
      @params.require(:employee).permit(:company_id)
    end
  end
end
