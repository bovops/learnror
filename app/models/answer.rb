class Answer < ActiveRecord::Base
  belongs_to :question, counter_cache: true, touch: true
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachmentable, dependent: :destroy
  validates :body, :user, :question, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank

  def accept
    answers = self.question.answers.where(accepted: true)
    if answers.count == 1 and answers.include?(self)
      return self
    end
    if answers.any?
      answers.map { |a| a.update!( accepted: false ) }
    end
    self.update!(accepted: true)

  end

end
