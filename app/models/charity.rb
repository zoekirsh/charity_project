class Charity < ActiveRecord::Base
    has_many :activities, :through => :charity_activities
end
