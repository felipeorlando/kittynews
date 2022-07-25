import classNames from 'classnames';
import PropTypes from 'prop-types';
import React, { useState } from 'react';
import { useLikeMutation } from '../graphql/mutations/like';
import { useUnlikeMutation } from '../graphql/mutations/unlike';

function LikeButton({ initialIsLiked, initialCount, postId }) {
  const [{ count, isLiked }, setState] = useState({
    count: initialCount,
    isLiked: initialIsLiked,
  });

  const [likeMutation, { loading: likeLoading }] = useLikeMutation();
  const [unlikeMutation, { loading: unlikeLoading }] = useUnlikeMutation();

  async function likeTrigger() {
    const { data: { like: { postLikesCount } } } = await likeMutation({ variables: { postId } });
    setState({ count: postLikesCount, isLiked: true });
  }

  async function unlikeTrigger() {
    const { data: { unlike: { postLikesCount } } } = await unlikeMutation({ variables: { postId } });
    setState({ count: postLikesCount, isLiked: false });
  }

  async function buttonClickHandler() {
    await (isLiked ? unlikeTrigger() : likeTrigger());
  }

  const disabledButton = likeLoading || unlikeLoading;
  const title = isLiked ? 'Unlike' : 'Like';

  const cx = classNames('action', {
    liked: isLiked,
  });

  return (
    <button 
      className={cx}
      disabled={disabledButton}
      id="like-button"
      onClick={buttonClickHandler}
      title={title}
    >
      {isLiked ? '🔽' : '🔼'} {count}
    </button>
  );
}

LikeButton.propTypes = {
  initialIsLiked: PropTypes.bool.isRequired,
  initialCount: PropTypes.number.isRequired,
  postId: PropTypes.number.isRequired,
};

export default LikeButton;