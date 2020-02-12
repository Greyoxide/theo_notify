class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.references :person, null: false, foreign_key: true
      t.date :date
      t.integer :kind
      t.string :title

      t.timestamps
    end
  end
end
