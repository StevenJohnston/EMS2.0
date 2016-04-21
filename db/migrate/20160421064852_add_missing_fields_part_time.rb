class AddMissingFieldsPartTime < ActiveRecord::Migration
  def change
    add_reference :part_time_employees, :part_time_employees, index: true
    add_column :part_time_employees, :verified, :bool, :default =>0
    add_reference :part_time_employees, :employee, index: true
  end
end
