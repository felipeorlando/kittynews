import * as React from 'react';
import Post from '../../components/Post';
import { usePostByIdQuery } from '../../graphql/queries/postById';
import renderComponent from '../../utils/renderComponent';

function PostsShow({ postId }) {
  const { data, error, loading } = usePostByIdQuery(+postId);

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  const { postById: post, viewer } = data;

  return (
    <>
      <div className="box">
        <Post
          key={post.id}
          commentsCount={post.commentsCount}
          forShow
          isLiked={post.likedByCurrentUser}
          isLoggedIn={viewer !== null}
          likesCount={post.likesCount}
          postId={+post.id}
          tagline={post.tagline}
          title={post.title}
          url={post.url}
        />
      </div>
      <div className="box">
        <h3>Comments</h3>

        {post.comments.map((comment) => (
          <div className="comment" key={comment.id}>
            <strong>{comment.user.name}</strong>
            <p>{comment.text}</p>
          </div>
        ))}

        <form className="comment">
          <textarea
            name="comment"
            placeholder="Add a comment..."
            rows={4}
          />
          <button className="submit">Add comment</button>
        </form>
      </div>
    </>
  );
}

renderComponent(PostsShow);
