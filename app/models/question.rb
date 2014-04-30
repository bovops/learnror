class Question < ActiveRecord::Base
	validates_presence_of 	:title
	validates_presence_of 	:body
	validates_length_of		:title, in: 5..255
end
