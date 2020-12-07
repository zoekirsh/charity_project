class AddActivityIncomeSumColumn < ActiveRecord::Migration[5.2]

  def change
    add_column :activities, :income_sum, :integer
  end

end