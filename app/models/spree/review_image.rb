class Spree::ReviewImage < ActiveRecord::Base
  has_attached_file :attachment, styles: { medium: "300x300>", thumb: "100x100>" }

  belongs_to :review

  scope :approved, -> { where(approved: true) }
  scope :not_approved, -> { where(approved: false) }

  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\z/
end
