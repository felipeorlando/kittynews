import PropTypes from 'prop-types';
import React from 'react';
import LikeAction from './LikeAction';

function Post({
  commentsCount,
  isLiked,
  isLoggedIn,
  likesCount,
  postId,
  tagline,
  title,
  url,
}) {
  return (
    <article className="post">
      <h2>
        <a href={`/posts/${postId}`}>{title}</a>
      </h2>
      <div className="url">
        <a href={url}>{url}</a>
      </div>
      <div className="tagline">{tagline}</div>
      <footer>
        <LikeAction
          count={likesCount}
          isLiked={isLiked}
          isLoggedIn={isLoggedIn}
          postId={postId}
        />
        <button className="action">💬 {commentsCount}</button>
      </footer>
    </article>
  );
}

Post.propTypes = {
  commentsCount: PropTypes.number.isRequired,
  isLiked: PropTypes.bool.isRequired,
  isLoggedIn: PropTypes.bool.isRequired,
  likesCount: PropTypes.number.isRequired,
  postId: PropTypes.number.isRequired,
  tagline: PropTypes.string.isRequired,
  title: PropTypes.string.isRequired,
  url: PropTypes.string.isRequired,
};

export default Post;
