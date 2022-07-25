require 'rails_helper'

describe Mutations::Like do
  let!(:user_author) { create :user }
  let!(:user) { create :user }
  let!(:post) { create :post, user: user_author }

  context 'when user is logged in' do
    context 'calls to like an existing post' do
      it 'returns like infos without errors' do
        result = call_mutation(current_user: user, post_id: post.id)

        expect(result[:like].post_id).to eq post.id
        expect(result[:post_likes_count]).to eq 1
        expect(result[:like].user_id).to eq user.id
        expect(result[:errors]).to eq []
        expect(post.likes.count).to eq 1
      end
    end

    context 'calls to like a non-existing post' do
      it 'returns nil and errors' do
        result = call_mutation(current_user: user, post_id: 99)

        expect(result[:like]).to be_nil
        expect(result[:post_likes_count]).to be_nil
        expect(result[:errors]).to eq ['Post must exist']
      end
    end
  end

  context 'when user is not logged in' do
    it 'raises an error' do
      expect { call_mutation(current_user: nil, post_id: post.id) }.to raise_error GraphQL::ExecutionError, 'current user is missing'
    end
  end
end
