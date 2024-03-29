module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :tagline, String, null: false
    field :url, String, null: false
    field :user, UserType, null: false
    field :comments, [CommentType], null: false
    field :comments_count, Int, null: false
    field :likes_count, Int, null: false
    field :liked_by_current_user, Boolean, null: true
  end
end
