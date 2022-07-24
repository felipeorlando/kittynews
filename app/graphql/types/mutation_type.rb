module Types
  class MutationType < Types::BaseObject
    field :user_update, mutation: Mutations::UserUpdate
    field :like, mutation: Mutations::Like
    field :unlike, mutation: Mutations::Unlike
  end
end
