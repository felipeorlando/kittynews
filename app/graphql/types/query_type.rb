module Types
  class QueryType < Types::BaseObject
    field :posts_all, [PostType], null: false

    field :viewer, ViewerType, null: true

    def posts_all
      posts = Post.reverse_chronological.all
      posts = posts.with_liked_field_from_user(current_user) if current_user?
      posts
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
