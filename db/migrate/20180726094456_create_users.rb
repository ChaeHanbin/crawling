class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :content
      t.string :subtitle
      t.integer :number

      t.timestamps null: false
    end
  end
end
