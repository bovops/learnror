require 'spec_helper'

describe Answer do
  it { should validate_presence_of :body }
  it { should validate_presence_of :user }
  it { should validate_presence_of :question }
  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_many :comments }
  it { should have_many :attachments }

end
