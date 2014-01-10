require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :username }

  it { should_not have_valid(:email).when("hithere","hi@there","hithere.com") }
  it { should have_valid(:email).when("hi@there.com","yolo@gmail.com") }

  it { should have_many(:cards).dependent(:destroy) }
  it { should have_many(:tags).dependent(:destroy) }
  it { should have_many(:review_lists).dependent(:destroy) }

  it { should validate_uniqueness_of :username }
end
