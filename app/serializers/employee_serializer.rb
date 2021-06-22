# frozen_string_literal: true

class EmployeeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :company_id
end
