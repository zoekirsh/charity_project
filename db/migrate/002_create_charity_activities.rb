class CreateCharityActivities < ActiveRecord::Migration[5.2]

    def change
        create_table :charity_activities do |t|
            t.integer :charity_id
            t.integer :activity_id
            t.timestamps
        end
    end

end