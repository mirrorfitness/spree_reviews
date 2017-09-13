class AddReviewVotesAndAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table "spree_reviews_votes" do |t|
      t.integer "review_id", null: false
      t.integer "score", null: false
      t.integer "user_id"
      t.string  "ip_address"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "spree_reviews_attachments" do |t|
      t.integer "review_id"
      t.boolean "approved", default: false
      t.attachment "file"
    end
  end
end
