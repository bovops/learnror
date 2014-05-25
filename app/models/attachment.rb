class Attachment < ActiveRecord::Base

  mount_uploader :file, FileUploader

  belongs_to :user
  belongs_to :attachmentable, polymorphic: true

end
