require 'spec_helper'

describe Tagging do
  it { should validate_presence_of :card_id }
  it { should validate_presence_of :tag_id }

  it { should belong_to(:card) }
  it { should belong_to(:tag) }
end
