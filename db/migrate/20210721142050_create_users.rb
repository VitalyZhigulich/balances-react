class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.integer :balance, null: false, unsigned: true, default: 1_000
    end
  end
end
