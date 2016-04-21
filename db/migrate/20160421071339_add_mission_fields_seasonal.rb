class AddMissionFieldsSeasonal < ActiveRecord::Migration
  def change
    add_reference :seasonals, :seasonals, index: true
  end
end
