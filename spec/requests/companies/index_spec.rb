# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies#index', type: :request do
  describe 'GET /companies' do
    let(:path) { companies_path }
    let(:params) { {} }
    let(:complete_company) { create :company, required_employee_number: 20 }
    let(:complete_sub_company) { create :company, parent_company: complete_company }
    let(:incomplete_sub_sub_company) do
      create :company,
             parent_company: complete_sub_company,
             required_employee_number: 20
    end
    subject { get path, params: params }

    before do
      1.upto(5) { create :employee, company: complete_sub_company }
      1.upto(15) { create :employee, company: incomplete_sub_sub_company }
    end

    context 'with_filter' do
      let(:params) { { filter: 'incomplete' } }
      let(:valid_fields) do
        {
          'data' => [
            {
              attributes: {
                required_employee_number: incomplete_sub_sub_company.required_employee_number,
                id: incomplete_sub_sub_company.id,
                parent_company_id: incomplete_sub_sub_company.parent_company_id
              }.stringify_keys,
              id: incomplete_sub_sub_company.id.to_s,
              type: 'company'
            }.stringify_keys
          ]
        }
      end

      it 'is successful' do
        subject
        expect(response).to have_http_status :ok
      end

      it 'returns correct amount of records' do
        subject
        expect(JSON.parse(response.body)['data'].length).to eq 1
      end

      it 'returns correct record' do
        subject
        expect(JSON.parse(response.body)).to include(valid_fields)
      end
    end

    context 'without filter' do
      it 'is successful' do
        subject
        expect(response).to have_http_status :ok
      end

      it 'returns correct amount of records' do
        subject
        expect(JSON.parse(response.body)['data'].length).to eq Company.count
      end
    end
  end
end
