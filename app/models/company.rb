class Company < ApplicationRecord
  belongs_to :company, optional: true, foreign_key: :parent_company_id
end
