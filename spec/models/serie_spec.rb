require 'rails_helper'

RSpec.describe Serie, type: :model do
  let(:serie) { build(:serie) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of :imdb }
  it { is_expected.to validate_presence_of :serie_type }

  # check fields
  it { is_expected.to respond_to(:imdb) }
  it { is_expected.to respond_to(:my_rating) }
  it { is_expected.to respond_to(:last_episode) }
  it { is_expected.to respond_to(:last_season) }
  it { is_expected.to respond_to(:poster_uri) }
  it { is_expected.to respond_to(:serie_type) }
  it { is_expected.to respond_to(:user_id) }
end
