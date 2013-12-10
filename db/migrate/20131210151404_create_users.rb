class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.string :ename
      t.string :cname
      t.string :etitle
      t.string :ctitle

      t.timestamps
    end
  end
end
