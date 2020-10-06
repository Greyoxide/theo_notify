class ChangeDefaultForPersonId < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:assignments, :person_id, true)
  end
end
