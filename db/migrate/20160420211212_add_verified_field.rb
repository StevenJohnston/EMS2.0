class AddVerifiedField < ActiveRecord::Migration
  def change
    add_column :full_time_employees, :verified, :bool, :default =>0
  end
end
