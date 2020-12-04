class Activity < ActiveRecord::Base
    has_many :charity_activities
    has_many :charities, :through => :charity_activities
end
