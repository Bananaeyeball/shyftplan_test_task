# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees#destroy', type: :request do
  describe 'DELETE /employees/:id' do
    let(:path) { employee_path(employee.id) }
    let!(:employee) { create :employee }
    subject { delete path }

    context 'valid params' do
      it 'creates company successfully' do
        expect { subject }.to change { Employee.count }.from(1).to(0)
        expect(response).to have_http_status 200
      end
    end

    context 'company does not exist' do
      before { employee.destroy }

      it 'responds with 404' do
        expect { subject }.not_to change { Employee.count }
        expect(response).to have_http_status 404
      end
    end
  end
end
