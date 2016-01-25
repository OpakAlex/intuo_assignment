class Api::V1::MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :description, :url, :created_at

  has_many :members, each_serializer: Api::V1::MemberSerializer, embed_in_root: true, embed: :ids
  has_many :directors, each_serializer: Api::V1::DirectorSerializer, embed_in_root: true, embed: :ids
end
