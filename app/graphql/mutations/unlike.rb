module Mutations
  class Unlike < Mutations::BaseMutation
    null true

    argument :post_id, Integer, required: true

    field :like, Types::LikeType, null: false
    field :post_likes_count, Integer, null: false
    field :errors, [String], null: false

    def resolve(post_id:)
      require_current_user!

      destroyed = current_user.likes.destroy_by(post_id: post_id)

      if destroyed.any?
        {
          like: destroyed.last,
          post_likes_count: destroyed.last.post.likes_count,
          errors: [],
        }
      else
        {
          like: nil,
          post_likes_count: nil,
          errors: ['Like must exist'],
        }
      end
    end
  end
end
