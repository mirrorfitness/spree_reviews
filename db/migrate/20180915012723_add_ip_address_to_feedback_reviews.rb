class AddIpAddressToFeedbackReviews < ActiveRecord::Migration[5.1]
  def self.up
    add_column :spree_feedback_reviews, :ip_address, :string
    add_index :spree_feedback_reviews, :ip_address
  end

  def self.down
    remove_column :spree_feedback_reviews, :ip_address
  end
end
