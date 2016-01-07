class CreateChoicesettings < ActiveRecord::Migration
  def change
    create_table :choicesettings do |t|
      t.string :task
      t.string :task_appinfo
      t.string :task_apporder
      t.string :appinfo_position
      t.string :apporder_position
			t.string :totalrating_position
			t.string :distribution_position

      t.timestamps
    end
  end
end
