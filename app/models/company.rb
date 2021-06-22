# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :parent_company,
             class_name: 'Company',
             optional: true,
             foreign_key: :parent_company_id
  has_many :employees, dependent: :destroy

  # TODO: rewrite using Arel
  scope :incomplete, lambda {
    sql = <<-SQL
      WITH RECURSIVE company_tree AS (
        SELECT companies.id as top_company_id,
               companies.id as company_id,
               companies.required_employee_number as required_number
        FROM companies

        UNION ALL

        SELECT top_company_id, companies.id, required_number
        FROM company_tree
        JOIN companies
        ON company_tree.company_id = companies.parent_company_id
      )

      SELECT company_tree.top_company_id, COUNT(*) AS employee_count, company_tree.required_number
      FROM company_tree
      JOIN employees ON employees.company_id = company_tree.company_id
      GROUP BY company_tree.top_company_id, company_tree.required_number
    SQL
    results = ActiveRecord::Base.connection.execute(sql)
    ids = results.select { |result| result['employee_count'] < result['required_number'] }
                 .map { |result| result['top_company_id'] }
    where(id: ids)
  }
end
