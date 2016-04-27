class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :description
      t.integer :mday
      t.integer :mday_max
      t.integer :wday
      t.string :img_name
    end
  end
end
