class Spree::ReviewVote < ActiveRecord::Base
  belongs_to :review
  belongs_to :user, class_name: Spree.user_class.to_s

  validates :score, inclusion: { in: [-1, 1] }
end