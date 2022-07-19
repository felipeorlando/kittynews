require 'rails_helper'

describe Post do
  describe '.reverse_chronological' do
    it 'returns the posts in reverse chronological order' do
      post_1 = create :post, created_at: 2.days.ago
      post_2 = create :post, created_at: 1.day.ago

      expect(described_class.reverse_chronological).to eq [post_2, post_1]
    end
  end

  describe '.with_liked_field_from_user' do
    it 'returns the posts with the liked_by_caller field' do
      user_1 = create :user
      user_2 = create :user

      post_1 = create :post, user: user_1
      post_2 = create :post, user: user_2
      post_3 = create :post, user: user_1

      create :like, post: post_1, user: user_1
      create :like, post: post_3, user: user_1

      result = described_class.with_liked_field_from_user(user_1.id).map do |post|
        post.attributes.slice('id', 'liked_by_caller')
      end

      result_sorted = result.sort_by { |post| post['id'] }

      expect(result_sorted).to eq [
        {
          'id' => post_1.id,
          'liked_by_caller' => 1
        },
        {
          'id' => post_2.id,
          'liked_by_caller' => 0
        },
        {
          'id' => post_3.id,
          'liked_by_caller' => 1
        }
      ]
    end
  end

  describe '#liked_by_current_user' do
    context 'post does not have liked_by_caller alias field' do
      it 'returns nil' do
        post = create :post

        expect(post.liked_by_current_user).to eq nil
      end
    end

    context 'post has liked_by_caller alias field' do
      let!(:user) { create :user }
      let!(:post_1) { create :post, user: user }
      let!(:post_2) { create :post, user: user }

      let!(:result) do
        create :like, post: post_1, user: user

        described_class.with_liked_field_from_user(user.id)
      end

      it 'returns true if the user has liked the post' do
        expect(result.find(post_1.id).liked_by_current_user).to eq true
      end

      it 'returns false if the user has not liked the post' do
        expect(result.find(post_2.id).liked_by_current_user).to eq false
      end
    end
  end
end
