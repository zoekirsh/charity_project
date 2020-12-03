class CreateCharities < ActiveRecord::Migration[5.2]

    def change
        create_table :charities do |t|
            t.integer :charity_category_id
            t.string :name
            t.integer :ein
            t.string :state
            t.integer :gross_fundraising
            t.integer :management_fees
            t.boolean :accepting_donations
            t.timestamps
        end
    end

end