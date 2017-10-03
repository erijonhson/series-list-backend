class Api::V1::SerieSerializer < ActiveModel::Serializer
  attributes :id, :imdb, :my_rating, :last_episode, :last_season, :poster_uri, :serie_type, :user_id,
             :created_at, :updated_at

  # belongs_to :user
end
