class EmployeeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :company_id
end
