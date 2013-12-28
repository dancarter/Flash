require 'spec_helper'

describe Card do
  it { should validate_presence_of :front }
  it { should validate_presence_of :back }
  it { should validate_presence_of :user_id }

  it { should have_many(:tags).through(:taggings) }
  it { should have_many(:taggings).dependent(:destroy) }
end
