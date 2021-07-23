class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: '', index: { unique: true }
      t.decimal :balance, precision: 15, scale: 2, default: 1_000
    end
  end
end
