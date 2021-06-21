class Company < ApplicationRecord
  belongs_to :parent_company, optional: true, foreign_key: :parent_company_id
end
