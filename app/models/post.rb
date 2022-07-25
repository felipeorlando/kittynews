# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  comments_count :integer          default(0), not null
#  likes_count    :integer          default(0), not null
#  tagline        :string           not null
#  title          :string           not null
#  url            :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user, required: true, inverse_of: :posts
  has_many :comments, dependent: :destroy, inverse_of: :post
  has_many :likes, dependent: :destroy, inverse_of: :post

  validates :title, :tagline, presence: true
  validates :url, url: true, presence: true

  scope :reverse_chronological, -> { order(arel_table[:created_at].desc) }
  
  scope :with_liked_field_from_user, lambda { |user_id|
    joins(sanitize_sql_array(["LEFT OUTER JOIN likes ON likes.post_id = posts.id AND likes.user_id = ?", user_id]))
      .distinct
      .select('posts.*, COUNT(likes.*) AS liked_by_caller')
      .group('posts.id')
  }

  scope :by_id_with_comments, -> (id) { includes(comments: [:user]).find(id) }

  def liked_by_current_user
    return nil unless self.respond_to?(:liked_by_caller)
    
    self.liked_by_caller > 0
  end
end
