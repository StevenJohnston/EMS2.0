class CreateTimeCards < ActiveRecord::Migration
  def change
    create_table :time_cards do |t|
      t.date :dateOf
      t.decimal :sunday
      t.decimal :monday
      t.decimal :tuesday
      t.decimal :wednesday
      t.decimal :thursday
      t.decimal :friday
      t.decimal :saturday

      t.timestamps null: false
    end
  end
end
