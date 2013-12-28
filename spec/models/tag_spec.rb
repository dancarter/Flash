require 'spec_helper'

describe Tag do
  it { should validate_presence_of :name }
  it { should validate_presence_of :user_id }
end
