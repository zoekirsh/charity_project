class CharityActivity < ActiveRecord::Base
    belongs_to :charity 
    belongs_to :activity
end
