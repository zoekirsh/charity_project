class AddIncomeAmountToCharities < ActiveRecord::Migration[5.2]

  def change
    add_column :charities, :income_amount, :integer
  end

end