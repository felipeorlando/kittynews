import * as React from 'react';
import CreateComment from '../../components/CreateComment';
import Post from '../../components/Post';
import { usePostByIdQuery } from '../../graphql/queries/postById';
import renderComponent from '../../utils/renderComponent';

function PostsShow({ postId }) {
  const postIdInt = +postId;
  const { data, error, loading } = usePostByIdQuery(postIdInt);

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  const { postById: post, viewer } = data;

  const isLoggedIn = !!viewer;

  return (
    <>
      <div className="box">
        <Post
          key={post.id}
          commentsCount={post.commentsCount}
          forShow
          isLiked={post.likedByCurrentUser}
          isLoggedIn={isLoggedIn}
          likesCount={post.likesCount}
          postId={postIdInt}
          tagline={post.tagline}
          title={post.title}
          url={post.url}
        />
      </div>
      {(isLoggedIn || post.commentsCount > 0) && (
        <div className="box" id="comments">
          <h3>Comments</h3>

          <div id="comments-list">
            {post.comments.map((comment) => (
              <div className="comment" key={comment.id}>
                <strong>{comment.user.name}</strong>
                <p>{comment.text}</p>
              </div>
            ))}
          </div>

          {isLoggedIn && <CreateComment postId={postIdInt} />}
        </div>
      )}
    </>
  );
}

renderComponent(PostsShow);
