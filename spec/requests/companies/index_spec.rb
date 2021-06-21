# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Companies#index', type: :request do
  describe 'GET /companies' do
    let(:path) { companies_path }
    let(:params) { {} }
    let(:complete_company) { create :company, required_employee_number: 20 }
    let(:complete_sub_company) { create :company, parent_company: complete_company }
    let(:incomplete_sub_sub_company) { create :company, parent_company: complete_sub_company, required_employee_number: 20 }
    subject { get path, params: params }

    before do
      1.upto(5) { create :employee, company: complete_sub_company }
      1.upto(15) { create :employee, company: incomplete_sub_sub_company }
    end

    context 'with_filter' do
      let(:params) { { filter: 'incomplete' } }

      it { is_expected.to have_http_status :ok }
      it 'returns correct amount of records'do
        expect(JSON.parse(response.body).length).to eq 1
      end
      it 'returns correct record'do
        expect(JSON.parse(response.body)).to include(id: incomplete_sub_sub_company.id)
      end
    end

    context 'without filter' do
      it { is_expected.to have_http_status :ok }
      it 'returns correct amount of records' do
        expect(JSON.parse(response.body).length).to eq Company.count
      end
    end
  end
end
