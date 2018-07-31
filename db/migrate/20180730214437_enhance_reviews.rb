class EnhanceReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :spree_reviews, :location
    add_column :spree_reviews, :featured, :boolean, default: false
    add_column :spree_reviews, :email, :string
    add_column :spree_reviews, :city, :string
    add_column :spree_reviews, :state, :string
  end
end
