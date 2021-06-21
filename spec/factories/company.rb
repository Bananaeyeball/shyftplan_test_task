FactoryBot.define do
  factory :company do
    required_emplyee_number 5
    association :parent_company, factory: :company
  end
end
