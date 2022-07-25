import gql from 'graphql-tag';
import { useQuery } from 'react-apollo';

export const POST_BY_ID = gql`
  query PostById($postId: Int!) {
    viewer {
      id
    }
    postById(postId: $postId) {
      id
      title
      tagline
      url
      commentsCount
      likesCount
      likedByCurrentUser
      comments {
        text
        createdAt
        user {
          name
        }
      }
    }
  }
`;

export const usePostByIdQuery = (postId) => {
  return useQuery(POST_BY_ID, { variables: { postId } });
};
