class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user

	validates :title, :body, :user, presence: true
	validates_length_of		:title, in: 5..255
end
