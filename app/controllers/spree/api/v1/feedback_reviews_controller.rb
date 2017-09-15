module Spree
  module Api
    module V1
      class FeedbackReviewsController < Spree::Api::BaseController
        before_action :sanitize_rating, only: :create
        before_action :load_review, only: :create

        def create
          if @review.present?
            @feedback_review = @review.feedback_reviews.new(feedback_review_params)
            @review.user = current_api_user
            @feedback_review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]
            authorize! :create, @feedback_review
          end

          if @feedback_review.save
            respond_with(@subscription, status: 201, default_template: :show)
          else
            invalid_resource!(@feedback_review)
          end
        end

        protected

        def load_review
          @review ||= Spree::Review.find_by_id!(params[:review_id])
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
