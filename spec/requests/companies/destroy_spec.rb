# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies#destroy', type: :request do
  describe 'DELETE /companies/:id' do
    let(:path) { company_path(company.id) }
    let!(:company) { create :company }
    subject { delete path }

    context 'valid params' do
      it 'creates company successfully' do
        expect { subject }.to change { Company.count }.from(1).to(0)
        expect(response).to have_http_status 200
      end
    end

    context 'company does not exist' do
      before { company.destroy }

      it 'responds with 404' do
        expect { subject }.not_to change { Company.count }
        expect(response).to have_http_status 404
      end
    end
  end
end
