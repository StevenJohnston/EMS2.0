class AddParentRefference < ActiveRecord::Migration
  def change
    add_reference :contract_employees, :contract_employees, index: true
  end
end
