class CreateContractEmployees < ActiveRecord::Migration
  def change
    create_table :contract_employees do |t|
      t.date :contractStartDate
      t.date :contractStopDate
      t.decimal :fixedContractAmount
      t.references :employee, index: true, foreign_key: true
      t.boolean :verified

      t.timestamps null: false
    end
  end
end
