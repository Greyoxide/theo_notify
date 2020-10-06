class AddStatusToAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :assignments, :status, :integer
  end
end
