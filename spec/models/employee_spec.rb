# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'factory' do
    subject { create :employee }

    it 'created employee' do
      expect { subject }.to change { Employee.count }.by 1
    end
  end
end
