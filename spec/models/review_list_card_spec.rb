require 'spec_helper'

describe ReviewListCard do
  it { should validate_presence_of :review_list }
  it { should validate_presence_of :card }

  it { should belong_to :review_list }
  it { should belong_to :card }
end
