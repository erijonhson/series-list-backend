class Serie < ApplicationRecord
  belongs_to :user

  enum serie_type: { watching: 0, wishing: 1 }

  validates :imdb, presence: true
  validates :serie_type, presence: true
end
