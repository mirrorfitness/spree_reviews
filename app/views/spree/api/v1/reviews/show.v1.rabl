object @review
cache [I18n.locale, @current_user_roles.include?('admin'), current_currency, root_object]

attributes *[:id, :product_id, :name, :location, :rating, :title, :review, :approved, :created_at, :updated_at, :user_id, :ip_address, :locale, :show_identifier]

child(feedback_reviews: :feedback_reviews) { extends 'spree/api/v1/feedback_reviews/show' }
child(review_images: :review_images) { extends 'spree/api/v1/review_images/show' }
