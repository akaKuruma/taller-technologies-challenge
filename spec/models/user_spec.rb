require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user, email: 'valid@user.com') }

  context 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }

    context 'with valid attributes' do
      it { is_expected.to be_valid }
    end

    context 'but invalid email format' do
     before { subject.email = 'invalid_email' }
      it { is_expected.not_to be_valid }
    end
  end
end
