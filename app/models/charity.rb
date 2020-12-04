class Charity < ActiveRecord::Base
  has_many :charity_activities
  has_many :activities, :through => :charity_activities
end
