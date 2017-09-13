class AddReviewAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table "spree_reviews_attachments" do |t|
      t.integer "review_id"
      t.boolean "approved", default: false
      t.attachment "file"
    end
  end
end
