class CreateTrades < ActiveRecord::Migration[5.1]
  def change
    create_table :trades do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.references :account, foreign_key: true, index: true

      t.timestamps
    end
  end
end
