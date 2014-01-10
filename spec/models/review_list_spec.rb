require 'spec_helper'

describe ReviewList do
  it { should have_many(:review_list_tags).dependent(:destroy) }
  it { should have_many(:review_list_cards).dependent(:destroy) }
  it { should have_many(:cards).through(:review_list_cards) }
  it { should have_many(:tags).through(:review_list_tags) }
end
