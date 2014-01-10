require 'spec_helper'

describe Card do
  it { should validate_presence_of :front }
  it { should validate_presence_of :back }
  it { should validate_presence_of :user }

  it { should have_many(:tags).through(:taggings) }
  it { should have_many(:taggings).dependent(:destroy) }
  it { should have_many(:review_list_cards).dependent(:destroy) }
  it { should belong_to :user }
end
