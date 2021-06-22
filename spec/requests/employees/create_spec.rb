# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees#create', type: :request do
  describe 'POST /employees' do
    let(:path) { employees_path }
    let(:company) { create :company }
    let(:params) { {} }
    subject { post path, params: params }

    context 'valid params' do
      let(:params) do
        {
          employee: {
            company_id: company.id
          }
        }
      end

      it 'creates company successfully' do
        expect { subject }.to change { Employee.count }.from(0).to(1)
        expect(response).to have_http_status 201
        expect(Employee.last.attributes).to include params[:employee].stringify_keys
      end
    end

    context 'invalid params' do
      it 'responds with 422' do
        expect { subject }.not_to change { Employee.count }
        expect(response).to have_http_status 422
      end
    end
  end
end
