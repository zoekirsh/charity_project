class CharityCategory < ActiveRecord::Base
    belongs_to :charity 
    belongs_to :category 
end
