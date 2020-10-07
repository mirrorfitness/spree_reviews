class Spree::ReviewImage < ActiveRecord::Base
  has_one_attached :attachment
  validates :attachment, file_content_type: { allow: ['image/jpeg', 'image/png'], if: -> { attachment.attached? } }

  belongs_to :review

  scope :approved, -> { where(approved: true) }
  scope :not_approved, -> { where(approved: false) }
end
