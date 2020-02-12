class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :status
      t.string :browsing_token
      t.string :invitation_token
      t.datetime :invitation_sent_at
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end
    add_index :users, :browsing_token, unique: true
    add_index :users, :invitation_token, unique: true
    add_index :users, :password_reset_token, unique: true
  end
end
