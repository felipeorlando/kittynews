import gql from 'graphql-tag';
import { useMutation } from 'react-apollo';

export const CREATE_COMMENT_MUTATION = gql`
  mutation CreateCommentMutation(
    $postId: Int!
    $text: String!
  ) {
    createComment(postId: $postId, text: $text) {
      comment {
        id
        text
        createdAt
        user {
          name
        }
      }
    }
  }
`;

export const useCreateCommentMutation = (options) => {
  return useMutation(CREATE_COMMENT_MUTATION, options);
};
