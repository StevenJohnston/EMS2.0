class AddLogTypeWhoCrud < ActiveRecord::Migration
  def change
    add_column :logs, :CRUD, :string
    add_column :logs, :table, :string
    add_column :logs, :who, :string
  end
end
