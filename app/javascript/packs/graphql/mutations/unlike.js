import gql from 'graphql-tag';
import { useMutation } from 'react-apollo';

export const UNLIKE_MUTATION = gql`
  mutation UnlikeMutation(
    $postId: Int!
  ) {
    unlike(postId: $postId) {
      postLikesCount
    }
  }
`;

export const useUnlikeMutation = () => {
  return useMutation(UNLIKE_MUTATION);
};
