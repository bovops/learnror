require 'rails_helper'

describe User do
  it { should validate_presence_of :email }
  it { should have_many :questions }
  it { should have_many :answers }
end
