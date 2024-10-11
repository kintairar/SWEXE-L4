class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :pass

      t.timestamps
    end
  end
end
