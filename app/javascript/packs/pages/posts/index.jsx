import * as React from 'react';
import Post from '../../components/Post';
import { usePostsAllQuery } from '../../graphql/queries/postsAll';
import renderComponent from '../../utils/renderComponent';

function PostsIndex() {
  const { data, loading, error } = usePostsAllQuery();

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;
  
  return (
    <div className="box">
      {data.postsAll.map((post) => (
        <Post
          key={post.id}
          commentsCount={post.commentsCount}
          isLiked={post.likedByCurrentUser}
          isLoggedIn={data.viewer !== null}
          likesCount={post.likesCount}
          postId={+post.id}
          tagline={post.tagline}
          title={post.title}
          url={post.url}
        />
      ))}
    </div>
  );
}

renderComponent(PostsIndex);
