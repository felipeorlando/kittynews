module Mutations
    class CreateComment < Mutations::BaseMutation
      null true
  
      argument :post_id, Integer, required: true
      argument :text, String, required: true
  
      field :comment, Types::CommentType, null: false
      field :errors, [String], null: false
  
      def resolve(post_id:, text:)
        require_current_user!
  
        comment = current_user.comments.new(post_id: post_id, text: text)
  
        if comment.save
          {
            comment: comment,
            errors: [],
          }
        else
          {
            comment: nil,
            errors: comment.errors.full_messages
          }
        end
      end
    end
  end
  