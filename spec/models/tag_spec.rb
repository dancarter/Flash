require 'spec_helper'

describe Tag do
  it { should validate_presence_of :name }
  it { should validate_presence_of :user }

  it { should have_many(:taggings).dependent(:destroy) }
  it { should have_many(:review_list_tags).dependent(:destroy) }
  it { should have_many(:cards).through(:taggings) }
  it { should belong_to :user }
end
