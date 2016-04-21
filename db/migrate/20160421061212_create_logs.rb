class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :employeeInfo
      t.text :additionalInfo

      t.timestamps null: false
    end
  end
end
