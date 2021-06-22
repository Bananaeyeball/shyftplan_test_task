# frozen_string_literal: true

class CompanySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :required_employee_number, :parent_company_id
end
