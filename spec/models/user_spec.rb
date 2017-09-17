require 'rails_helper'


RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  # it { is_expected.to have_many(:series).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('example@email.com').for(:email) }

end
