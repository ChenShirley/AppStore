class CreateSubjectinfos < ActiveRecord::Migration
  def change
    create_table :subjectinfos do |t|
      t.string :esearch
      t.string :regulatory_focus
      t.integer :mobile_user
      t.integer :appstore
      t.integer :visit_frequency
      t.integer :app_expense
      t.integer :previous_experience
      t.string :ip_address
      t.datetime :start_time
      t.string :browser
      t.string :browser_version
      t.string :platform
      t.string :os

      t.references :choicesetting

      t.timestamps
    end
  end
end
