module Spree
  module Api
    module V1
      class FeedbackReviewsController < Spree::Api::BaseController
        before_action :sanitize_rating, only: :create
        before_action :load_review, only: :create

        def create
          if @review.present?
            @feedback_review = FeedbackReview.find_by ip_address: request.remote_ip, review_id: @review.id

            # Dissallow multiple reviews with the same ip address
            @feedback_review = @review.feedback_reviews.new(feedback_review_params) if @feedback_review.nil?

            @review.user = current_api_user

            @feedback_review.rating = feedback_review_params[:rating]
            @feedback_review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]
            @feedback_review.ip_address = request.remote_ip
          end

          if @feedback_review.save
            @review.reload
            respond_with(@review, status: 201, default_template: :show)
          else
            invalid_resource!(@feedback_review)
          end
        end

        protected

        def load_review
          @review = Spree::Review.find_by_id!(params[:review_id])
        end

        def permitted_feedback_review_attributes
          [:rating, :comment]
        end

        def feedback_review_params
          params.require(:feedback_review).permit(permitted_feedback_review_attributes)
        end

        def sanitize_rating
          params[:feedback_review][:rating].to_s.sub!(/\s*[^0-9]*\z/, '') unless params[:feedback_review] && params[:feedback_review][:rating].blank?
        end
      end
    end
  end
end
