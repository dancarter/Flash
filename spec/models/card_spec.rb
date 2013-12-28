require 'spec_helper'

describe Card do
  it { should validate_presence_of :front }
  it { should validate_presence_of :back }
  it { should validate_presence_of :user_id }
end
