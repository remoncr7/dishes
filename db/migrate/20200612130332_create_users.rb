class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :mail_adress
      t.string :password
      t.integer :age

      t.timestamps
    end
  end
end
