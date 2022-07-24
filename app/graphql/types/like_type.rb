module Types
  class LikeType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :post_id, ID, null: false
  end
end
