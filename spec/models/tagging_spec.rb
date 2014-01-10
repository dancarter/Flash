require 'spec_helper'

describe Tagging do
  before(:all) { FactoryGirl.create(:tagging) }

  it { should validate_presence_of :card_id }
  it { should validate_presence_of :tag_id }

  it { should belong_to(:card) }
  it { should belong_to(:tag) }

  it { should validate_uniqueness_of(:card_id).scoped_to(:tag_id) }
end
