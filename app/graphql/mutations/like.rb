module Mutations
  class Like < Mutations::BaseMutation
    null true

    argument :post_id, Integer, required: true

    field :like, Types::LikeType, null: false
    field :post_likes_count, Integer, null: false
    field :errors, [String], null: false

    def resolve(post_id:)
      require_current_user!

      like = current_user.likes.new(post_id: post_id)

      if like.save
        {
          like: like,
          post_likes_count: like.post.likes_count,
          errors: [],
        }
      else
        {
          like: nil,
          post_likes_count: nil,
          errors: like.errors.full_messages
        }
      end
    end
  end
end
