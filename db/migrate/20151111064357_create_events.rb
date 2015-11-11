class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :esearch
      t.string :regulatory_focus
      t.integer :apporder
      t.string :appname
      t.integer :review
      t.integer :detail
      t.integer :purchase
      t.datetime :access_time
      t.datetime :leave_time

      t.timestamps
    end
  end
end
