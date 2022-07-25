module Types
  class QueryType < Types::BaseObject
    field :posts_all, [PostType], null: false

    field :post_by_id, PostType, null: true do
      argument :post_id, Integer, required: true
    end
  
    field :viewer, ViewerType, null: true

    def posts_all
      posts = Post.reverse_chronological.all
      posts = posts.with_liked_field_from_user(current_user.id) if current_user?
      posts
    end

    def post_by_id(post_id:)
      post = Post.where({})
      post = post.with_liked_field_from_user(current_user.id) if current_user?
      post = post.by_id_with_comments(post_id)
      post
    end

    def viewer
      context.current_user
    end

    private def current_user?
      current_user.present?
    end

    private def current_user
      context[:current_user]
    end
  end
end
