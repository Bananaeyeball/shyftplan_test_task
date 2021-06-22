# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies#create', type: :request do
  describe 'POST /companies' do
    let(:path) { companies_path }
    let(:params) { {} }
    subject { post path, params: params }

    context 'valid params' do
      let(:params) do
        {
          company: {
            required_employee_number: 20,
            parent_company_id: nil
          }
        }
      end

      it 'creates company successfully' do
        expect { subject }.to change { Company.count }.from(0).to(1)
        expect(response).to have_http_status 201
        expect(Company.last.attributes).to include params[:company].stringify_keys
      end
    end

    context 'invalid params' do
      it 'responds with 422' do
        expect { subject }.not_to change { Company.count }
        expect(response).to have_http_status 422
      end
    end
  end
end
