require 'rails_helper'

describe Types::QueryType do
  subject(:result) { KittynewsSchema.execute(query, context: context).as_json }

  describe '#posts_all' do
    let(:user) { create :user, name: "Yo!" }
    let(:query) do
      %(
        query {
          postsAll {
            id
            likedByCurrentUser
          }
        }
      )
    end

    context 'when user is logged in' do
      let(:context) { { current_user: user } }

      it 'returns all posts with liked field from user' do
        post_1 = create :post, user: user
        post_2 = create :post, user: user
        post_3 = create :post, user: user

        create :like, user: user, post: post_1

        result_sorted = result['data']['postsAll'].sort_by { |post| post['id'] }

        expect(result_sorted).to eq [
          {
            'id' => post_1.id.to_s,
            'likedByCurrentUser' => true,
          },
          {
            'id' => post_2.id.to_s,
            'likedByCurrentUser' => false,
          },
          {
            'id' => post_3.id.to_s,
            'likedByCurrentUser' => false,
          },
        ]
      end
    end

    context 'when user is not logged in' do
      let(:context) { {} }

      it 'returns all posts without liked field' do
        post_1 = create :post, user: user
        post_2 = create :post, user: user
        post_3 = create :post, user: user

        result_sorted = result['data']['postsAll'].sort_by { |post| post['id'] }

        expect(result_sorted).to eq [
          {
            'id' => post_1.id.to_s,
            'likedByCurrentUser' => nil,
          },
          {
            'id' => post_2.id.to_s,
            'likedByCurrentUser' => nil,
          },
          {
            'id' => post_3.id.to_s,
            'likedByCurrentUser' => nil,
          },
        ]
      end
    end
  end
end
