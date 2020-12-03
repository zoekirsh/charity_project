class Charity < ActiveRecord::Base
    has_many :categories, :through => :charity_categories
end
