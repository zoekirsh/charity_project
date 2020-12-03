class Activity < ActiveRecord::Base
    has_many :charities, :through => :charity_activities
end
