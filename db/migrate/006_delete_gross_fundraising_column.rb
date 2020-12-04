class DeleteGrossFundraisingColumn < ActiveRecord::Migration[5.2]

  def change
    remove_column :charities, :gross_fundraising
  end

end