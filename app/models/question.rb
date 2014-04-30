class Question < ActiveRecord::Base
	validates :title, :body, presence: true
	validates_length_of		:title, in: 5..255
end
