class Question < ActiveRecord::Base
  has_many :answers

	validates :title, :body, presence: true
	validates_length_of		:title, in: 5..255
end
