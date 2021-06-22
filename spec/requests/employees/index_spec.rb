# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees#index', type: :request do
  describe 'GET /employees' do
    let(:path) { employees_path }
    let(:company) { create :company, required_employee_number: 20 }
    subject { get path }

    before do
      1.upto(25) { create :employee, company: company }
    end

    it 'is successful' do
      subject
      expect(response).to have_http_status :ok
    end

    it 'returns correct amount of records' do
      subject
      expect(JSON.parse(response.body)['data'].length).to eq Employee.count
    end
  end
end
