import gql from 'graphql-tag';
import { useQuery } from 'react-apollo';

export const POSTS_ALL_QUERY = gql`
  query PostsAllQuery {
    viewer {
      id
    }
    postsAll {
      id
      title
      tagline
      url
      commentsCount
      likesCount
      likedByCurrentUser
    }
  }
`;

export const usePostsAllQuery = () => {
  return useQuery(POSTS_ALL_QUERY);
};
