import PropTypes from 'prop-types';
import React, { useState } from 'react';
import { useCreateCommentMutation } from '../graphql/mutations/createComment';
import { POST_BY_ID } from '../graphql/queries/postById';

function CreateComment({ postId }) {
  const [text, setText] = useState('');

  const [createComment, { loading }] = useCreateCommentMutation({
    update(cache, { data: { createComment } }) {
      const { viewer, postById } = cache.readQuery({ query: POST_BY_ID, variables: { postId: postId } });

      cache.writeQuery({
        query: POST_BY_ID,
        variables: { postId: postId },
        data: {
          viewer: viewer,
          postById: {
            ...postById,
            comments: [...postById.comments, createComment.comment],
          },
        },
      });
    }
  });

  async function formSubmitHandler(e) {
    e.preventDefault();
    try {
      const { data } = await createComment({ variables: { postId, text } });
      setText('');
    } catch (err) {
      console.error(err);
    }
  }

  const textAreaChangeHandler = (e) => {
    setText(e.target.value);
  }

  const disabled = loading;

  return (
    <form className="comment" id="create-comment" onSubmit={formSubmitHandler}>
      <textarea
        disabled={disabled}
        name="comment"
        onChange={textAreaChangeHandler}
        placeholder="Add a comment..."
        rows={4}
        value={text}
      />
      <button className="submit" disabled={disabled}>
        Add comment
      </button>
    </form>
  );
}

CreateComment.propTypes = {
  postId: PropTypes.number.isRequired,
};

export default CreateComment;
