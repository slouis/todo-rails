class List < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :user_id
  has_many :tasks
end
