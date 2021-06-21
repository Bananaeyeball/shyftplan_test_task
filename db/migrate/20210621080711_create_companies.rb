class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.integer :required_employee_number
      t.integer :parent_company_id, foreign_key: true

      t.timestamps
    end
  end
end
