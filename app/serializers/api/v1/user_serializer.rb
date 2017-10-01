class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :tokens, :created_at, :updated_at
end
