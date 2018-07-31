module Spree
  module Api
    module V1
      class ReviewsController < Spree::Api::BaseController
        before_action :load_product, only: [:index, :create]

        def index
          @approved_reviews = Spree::Review.approved.where(product: @product)
          respond_with(@approved_reviews)
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
            respond_with(@review, status: 201, default_template: :show)
          else
            invalid_resource!(@review)
          end
        end

        private

        def load_product
          @product = Spree::Product.friendly.find(params[:product_id])
        end

        def permitted_review_attributes
          [:rating, :title, :review, :name, :show_identifier, :location, review_images_attributes: [:attachment]]
        end

        def review_params
          params.require(:review).permit(permitted_review_attributes)
        end
      end
    end
  end
end
