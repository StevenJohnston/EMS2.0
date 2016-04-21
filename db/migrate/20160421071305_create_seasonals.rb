class CreateSeasonals < ActiveRecord::Migration
  def change
    create_table :seasonals do |t|
      t.string :season
      t.integer :seasonYear
      t.decimal :piecePay
      t.references :employee, index: true, foreign_key: true
      t.boolean :verified

      t.timestamps null: false
    end
  end
end
