module Spree
  module Admin
    class ReviewImagesController < ResourceController
      belongs_to 'spree/review'
    end
  end
end
