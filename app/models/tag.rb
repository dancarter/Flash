class Tag < ActiveRecord::Base
  validate_presence_of :name
  validate_presence_of :user_id
end
