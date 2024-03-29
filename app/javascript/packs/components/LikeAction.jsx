import PropTypes from 'prop-types';
import React from 'react';

import LikeLink from './LikeLink';
import LikeButton from './LikeButton';

function LikeAction({ count, isLiked, isLoggedIn, postId }) {
  if (!isLoggedIn) return <LikeLink count={count} />

  return (
    <LikeButton
      initialCount={count}
      initialIsLiked={isLiked}
      postId={postId}
    />
  );
}

LikeAction.propTypes = {
  count: PropTypes.number.isRequired,
  isLiked: PropTypes.bool.isRequired,
  isLoggedIn: PropTypes.bool.isRequired,
  postId: PropTypes.number.isRequired,
};

export default LikeAction;