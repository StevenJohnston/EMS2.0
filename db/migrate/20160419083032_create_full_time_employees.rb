class CreateFullTimeEmployees < ActiveRecord::Migration
  def change
    create_table :full_time_employees do |t|
      t.date :dateOfHire
      t.date :dateofTermination
      t.decimal :salary
      t.references :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
