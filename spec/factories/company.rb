# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    required_employee_number { 5 }
    trait :with_parent_company do
      after :build do |i|
        i.parent_company = create(:company)
      end
    end
  end
end
