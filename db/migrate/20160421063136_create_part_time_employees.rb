class CreatePartTimeEmployees < ActiveRecord::Migration
  def change
    create_table :part_time_employees do |t|
      t.date :dateOfHire
      t.date :dateOfTermination
      t.decimal :hourlyRate

      t.timestamps null: false
    end
  end
end
