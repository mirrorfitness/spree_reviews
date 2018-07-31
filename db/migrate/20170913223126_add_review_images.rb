class AddReviewImages < ActiveRecord::Migration
  def change
    create_table 'spree_review_images' do |t|
      t.integer 'review_id'
      t.attachment 'attachment'
    end
  end
end
