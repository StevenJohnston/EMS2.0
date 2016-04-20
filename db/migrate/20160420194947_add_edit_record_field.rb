class AddEditRecordField < ActiveRecord::Migration
  def change
    add_reference :full_time_employees, :full_time_employees, index: true
  end
end
