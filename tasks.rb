
class Tasks < ActiveRecord::Base
  validates :description, presence: true
end
