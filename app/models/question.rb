class Question < ActiveRecord::Base

  acts_as_taggable

  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  belongs_to :user

	validates :title, :body, :user, presence: true
	validates_length_of		:title, in: 5..255

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank
end
