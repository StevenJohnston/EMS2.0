class AddEditor < ActiveRecord::Migration
  def change
    add_reference :employees, :editor, references: :user, index: true
  end
end
