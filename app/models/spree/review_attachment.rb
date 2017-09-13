class Spree::ReviewAttachment < ActiveRecord::Base
  has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  belongs_to :review

  scope :approved, -> { where(approved: true) }
  scope :not_approved, -> { where(approved: false) }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end