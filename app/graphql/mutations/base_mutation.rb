module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    def require_current_user!
      if current_user.nil?
        raise GraphQL::ExecutionError, 'current user is missing' 
      end
    end

    def current_user
      context[:current_user]
    end
  end
end
