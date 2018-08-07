class AddFeedbackCount < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_reviews, :feedback_reviews_count, :integer, default: 0
  end
end
