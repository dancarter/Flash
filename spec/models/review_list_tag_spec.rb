require 'spec_helper'

describe ReviewListTag do
  it { should validate_presence_of :review_list }
  it { should validate_presence_of :tag }

  it { should belong_to :review_list }
  it { should belong_to :tag }
end
