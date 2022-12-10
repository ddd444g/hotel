class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :profile
      t.string :email
      t.string :password
      t.string :icon

      t.timestamps
    end
  end
end
