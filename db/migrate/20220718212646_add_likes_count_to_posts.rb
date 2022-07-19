class AddLikesCountToPosts < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.integer :likes_count, null: false, default: 0
    end
  end
end
