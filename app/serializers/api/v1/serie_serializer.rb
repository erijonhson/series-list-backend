class Api::V1::SerieSerializer < ActiveModel::Serializer
  attributes :id, :imdb, :my_rating, :last_episode, :serie_type, :user_id,
             :created_at, :updated_at

  # belongs_to :user
end
