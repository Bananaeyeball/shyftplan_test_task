# frozen_string_literal: true

module Companies
  class CreateService
    def initialize(params)
      @params = params
    end

    def call
      Company.new(create_params).save!
      201
    rescue ActiveRecord::RecordInvalid, ActionController::ParameterMissing
      422
    end

    private

    def create_params
      @params.require(:company).permit(:required_employee_number, :parent_company_id)
    end
  end
end
