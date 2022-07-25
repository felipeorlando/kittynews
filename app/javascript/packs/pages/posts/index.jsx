import * as React from 'react';
import renderComponent from '../../utils/renderComponent';
import LikeAction from '../../components/LikeAction';
import { usePostsAllQuery } from '../../graphql/queries/postsAll';

function PostsIndex() {
  const { data, loading, error } = usePostsAllQuery();

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;
  
  return (
    <div className="box">
      {data.postsAll.map((post) => (
        <article className="post" key={post.id}>
          <h2>
            <a href={`/posts/${post.id}`}>{post.title}</a>
          </h2>
          <div className="url">
            <a href={post.url}>{post.url}</a>
          </div>
          <div className="tagline">{post.tagline}</div>
          <footer>
            <LikeAction
              count={post.likesCount}
              isLiked={post.likedByCurrentUser}
              isLogged={data.viewer !== null}
              postId={+post.id}
            />
            <button className="action">💬 {post.commentsCount}</button>
          </footer>
        </article>
      ))}
    </div>
  );
}

renderComponent(PostsIndex);
