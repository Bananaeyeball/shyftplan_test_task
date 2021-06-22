# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'factory' do
    subject { create :company, :with_parent_company }

    it 'created company with parent company' do
      expect { subject }.to change { Company.count }.by 2
    end
  end

  describe 'incomplete companies' do
    let(:complete_company) { create :company, required_employee_number: 20 }
    let(:complete_sub_company) { create :company, parent_company: complete_company }
    let(:incomplete_sub_sub_company) do
      create :company,
             parent_company: complete_sub_company,
             required_employee_number: 20
    end
    subject { Company.incomplete }

    context 'there are incomplete companies' do
      before do
        1.upto(5) { create :employee, company: complete_sub_company }
        1.upto(15) { create :employee, company: incomplete_sub_sub_company }
      end

      it 'returns companies with amount of workers less than required' do
        is_expected.to match_array [incomplete_sub_sub_company]
      end
    end

    context 'there are no incomplete companies' do
      before do
        1.upto(5) { create :employee, company: complete_sub_company }
        1.upto(25) { create :employee, company: incomplete_sub_sub_company }
      end

      it 'returns companies with amount of workers less than required' do
        is_expected.to be_empty
      end
    end
  end
end
