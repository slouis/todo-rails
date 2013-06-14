class List < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :user_id
  has_many :tasks, :order => 'sort ASC', :dependent => :delete_all
end
