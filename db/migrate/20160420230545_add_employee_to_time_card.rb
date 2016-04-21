class AddEmployeeToTimeCard < ActiveRecord::Migration
  def change
    add_reference :time_cards, :employee, index: true
  end
end
