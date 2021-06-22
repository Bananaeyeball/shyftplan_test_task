# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies#update', type: :request do
  describe 'PUT /companies/:id' do
    let(:path) { company_path(company.id) }
    let!(:company) { create :company, required_employee_number: 20 }
    let!(:parent_company) { create :company }
    let(:params) { {} }
    subject { put path, params: params }

    context 'valid params' do
      let(:params) do
        {
          company: {
            required_employee_number: 10,
            parent_company_id: parent_company.id
          }
        }
      end

      it 'creates company successfully' do
        expect { subject }
          .to change { company.reload.required_employee_number }
          .from(20)
          .to(10)
          .and change { company.parent_company_id }
          .from(nil)
          .to(parent_company.id)
        expect(company.attributes).to include params[:company].stringify_keys
        expect(response).to have_http_status 200
      end
    end

    context 'invalid params' do
      it 'responds with 422' do
        expect { subject }.not_to change { company.reload }
        expect(response).to have_http_status 422
      end
    end

    context 'company does not exist' do
      before { company.destroy }

      it 'responds with 404' do
        subject
        expect(response).to have_http_status 404
      end
    end
  end
end
