require 'rails_helper'

describe Mutations::Unlike do
  let!(:user_author) { create :user }
  let!(:user) { create :user }
  let!(:post) { create :post, user: user_author }

  before do
    create :like, user: user, post: post
  end

  context 'when user is logged in' do
    context 'calls to unlike an existing like' do
      it 'returns like infos without errors' do
        result = call_mutation(current_user: user, post_id: post.id)

        expect(result[:like].post_id).to eq post.id
        expect(result[:like].user_id).to eq user.id
        expect(result[:post_likes_count]).to eq 0
        expect(result[:errors]).to eq []
        expect(post.likes.count).to eq 0
      end
    end

    context 'calls to unlike a non-existing like' do
      it 'returns nil and errors' do
        result = call_mutation(current_user: user, post_id: 99)

        expect(result[:like]).to be_nil
        expect(result[:post_likes_count]).to be_nil
        expect(result[:errors]).to eq ['Like must exist']
      end
    end
  end

  context 'when user is not logged in' do
    it 'raises an error' do
      expect { call_mutation(current_user: nil, post_id: post.id) }.to raise_error GraphQL::ExecutionError, 'current user is missing'
    end
  end
end
