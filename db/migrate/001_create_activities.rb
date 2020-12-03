class CreateActivities < ActiveRecord::Migration[5.2]

    def change
        create_table :activities do |t|
            t.integer :charity_activity_id
            t.string :activity_desc
            t.timestamps
        end
    end

end