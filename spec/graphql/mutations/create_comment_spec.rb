require 'rails_helper'

describe Mutations::CreateComment do
  let!(:user) { create :user }
  let!(:post) { create :post }
  let!(:text) { 'This is a comment' }

  context 'when user is logged in' do
    context 'calls to create a comment with valid params' do
      it 'returns comment infos without errors' do
        result = call_mutation(current_user: user, post_id: post.id, text: text)

        expect(result[:comment].post_id).to eq post.id
        expect(result[:comment].text).to eq 'This is a comment'
        expect(result[:errors]).to eq []
        expect(post.comments.count).to eq 1
      end
    end

    context 'calls to create a comment with inexisting post' do
      it 'returns nil and errors' do
        result = call_mutation(current_user: user, post_id: 99, text: text)

        expect(result[:comment]).to be_nil
        expect(result[:errors]).to eq ['Post must exist']
      end
    end

    context 'calls to create a comment with empty text' do
      it 'returns nil and errors' do
        result = call_mutation(current_user: user, post_id: post.id, text: '')

        expect(result[:comment]).to be_nil
        expect(result[:errors]).to eq ["Text can't be blank"]
      end
    end
  end

  context 'when user is not logged in' do
    it 'raises an error' do
      expect { call_mutation(current_user: nil, post_id: post.id, text: text) }.to raise_error GraphQL::ExecutionError, 'current user is missing'
    end
  end
end
