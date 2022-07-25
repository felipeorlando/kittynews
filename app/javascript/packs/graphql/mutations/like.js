import gql from 'graphql-tag';
import { useMutation } from 'react-apollo';

export const LIKE_MUTATION = gql`
  mutation LikeMutation(
    $postId: Int!
  ) {
    like(postId: $postId) {
      postLikesCount
    }
  }
`;

export const useLikeMutation = () => {
  return useMutation(LIKE_MUTATION);
};
