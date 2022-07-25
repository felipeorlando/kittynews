require 'rails_helper'

describe Types::QueryType do
  subject(:result) { KittynewsSchema.execute(query, context: context).as_json }

  describe '#post_by_id' do
    let!(:user) { create :user }
    let!(:post_1) { create :post, user: user }
    let!(:post_2) { create :post, user: user }

    let(:query) do
      %(
        query {
          postById(postId: #{post_2.id}) {
            id
            title
            likedByCurrentUser
          }
        }
      )
    end

    context 'when user is logged in' do
      let(:context) { { current_user: user } }

      it 'returns all posts with liked field from user' do
        create :like, post: post_2, user: user

        post_finded = result['data']['postById']

        expect(post_finded['id']).to eq post_2.id.to_s
        expect(post_finded['title']).to eq post_2.title
        expect(post_finded['likedByCurrentUser']).to be_truthy
      end
    end

    context 'when user is not logged in' do
      let(:context) { {} }

      it 'returns all posts without liked field' do
        create :like, post: post_2, user: user

        post_finded = result['data']['postById']

        expect(post_finded['id']).to eq post_2.id.to_s
        expect(post_finded['title']).to eq post_2.title
        expect(post_finded['likedByCurrentUser']).to be_nil
      end
    end
  end
end
