require 'spec_helper'

describe Attachment do
  it { should belong_to :user }
  it { should belong_to :attachmentable }
end