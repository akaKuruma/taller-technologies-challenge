require 'rails_helper'
RSpec.describe Book, type: :model do
  subject { build(:book) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
