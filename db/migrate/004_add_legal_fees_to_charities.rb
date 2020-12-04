class AddLegalFeesToCharities < ActiveRecord::Migration[5.2]

  def change
    add_column :charities, :legal_fees, :integer
  end

end