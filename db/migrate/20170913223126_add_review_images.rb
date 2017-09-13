class AddReviewImages < ActiveRecord::Migration[5.1]
  def change
    create_table "spree_reviews_images" do |t|
      t.integer "review_id"
      t.boolean "approved", default: false
      t.attachment "attachment"
    end
  end
end
