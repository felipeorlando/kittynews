module Types
  class MutationType < Types::BaseObject
    field :create_comment, mutation: Mutations::CreateComment
    field :like, mutation: Mutations::Like
    field :unlike, mutation: Mutations::Unlike
    field :user_update, mutation: Mutations::UserUpdate
  end
end
