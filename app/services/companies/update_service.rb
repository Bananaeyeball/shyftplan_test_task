# frozen_string_literal: true

module Companies
  class UpdateService
    ERROR_TO_STATUS_MAP = {
      'ActiveRecord::RecordInvalid' => 422,
      'ActionController::ParameterMissing' => 422,
      'ActiveRecord::RecordNotFound' => 404
    }.freeze

    def initialize(params)
      @params = params
    end

    def call
      Company.find(@params[:id]).update!(update_params)
      200
    rescue ActiveRecord::RecordNotFound, ActionController::ParameterMissing, ActiveRecord::RecordInvalid => e
      ERROR_TO_STATUS_MAP[e.class.name]
    end

    private

    def update_params
      @params.require(:company).permit(:required_employee_number, :parent_company_id)
    end
  end
end
