class Task < ActiveRecord::Base
  belongs_to :list
  attr_accessible :list_id, :name, :sort
end
