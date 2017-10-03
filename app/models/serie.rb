class Serie < ApplicationRecord
  belongs_to :user

  enum serie_type: { watching: 0, wishing: 1 }

  validates :title, presence: true
  validates :imdb, presence: true
  validates :poster_uri, presence: true
  validates :serie_type, presence: true
end
