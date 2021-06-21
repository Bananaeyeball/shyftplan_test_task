require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:parent_company) { create :company }
  describe 'factory' do
    subject { create :company, parent_company: parent_company }

    it { is_expected.to change(Company.count).by 1 }
  end
end
