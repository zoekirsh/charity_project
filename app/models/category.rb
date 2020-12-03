class Category < ActiveRecord::Base
    has_many :charities, :through => :charity_categories
end
