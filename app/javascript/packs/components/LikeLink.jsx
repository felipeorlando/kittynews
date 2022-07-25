import PropTypes from 'prop-types';
import React from 'react';

function LikeLink({ count }) {
  return (
    <a
      className="action"
      href="/users/sign_in"
      id="like-link"
      title="Login to like"
    >
      🔼 {count}
    </a>
  );
}

LikeLink.propTypes = {
  count: PropTypes.number.isRequired,
};

export default LikeLink;