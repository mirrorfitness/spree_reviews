module Spree
  module Api
    module V1
      class ReviewsController < Spree::Api::BaseController
        before_action :load_product, only: [:index, :create]

        def index
          @approved_reviews = Spree::Review
            .approved.where(product: @product)
            .eager_load(:review_images)

          if params[:featured].present?
            @approved_reviews = @approved_reviews.where(featured: true)
          end

          respond_with @approved_reviews
        end

        # save if all ok
        def create
          authorize! :create, Review

          review_params[:rating].to_s.sub!(/\s*[^0-9]*\z/, '') unless review_params[:rating].blank?

          @review = Spree::Review.new(review_params)
          @review.product = @product
          @review.user = current_api_user
          @review.ip_address = request.remote_ip
          @review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]

          if @review.save
            if Spree::Reviews::Config[:include_unapproved_reviews]
              respond_with(@review, status: 201, default_template: :show)
            else
              head :no_content
            end
          else
            invalid_resource!(@review)
          end
        end

        private

        def load_product
          @product = Spree::Product.friendly.find(params[:product_id])
        end

        def permitted_review_attributes
          [:rating, :title, :review, :name, :show_identifier, :city, :state, review_images_attributes: [:attachment]]
        end

        def review_params
          params.require(:review).permit(permitted_review_attributes)
        end

        # TODO Use in index response
        def paginate(scope, default_per_page = 20)
          collection = scope.page(params[:page] || 1).per((params[:per_page] || default_per_page).to_i)
          current = collection.current_page
          total = collection.total_pages
          per_page = collection.limit_value
          [{
            pagination: {
              current:  current,
              previous: (current > 1 ? (current - 1) : nil),
              next:     (current == total ? nil : (current + 1)),
              per_page: per_page,
              pages:    total,
              count:    collection.total_count
            }
          }, collection]
        end

      end
    end
  end
end

