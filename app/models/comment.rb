class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, :user, :commentable, presence: true
end
