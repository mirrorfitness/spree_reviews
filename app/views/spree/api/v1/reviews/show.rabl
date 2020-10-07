object @review

attributes :id, :product_id, :name, :city, :state, :rating, :title, :review, :created_at, :updated_at, :user_id, :locale, :feedback_stars

child(review_images: :review_images) { extends 'spree/api/v1/review_images/show' }
