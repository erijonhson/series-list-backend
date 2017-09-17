class Serie < ApplicationRecord
  belongs_to :user

  enum serie_type: { perfil: 0, watchlist: 1 }

  validates :imdb, presence: true
end
