class CreateMockupapps < ActiveRecord::Migration
  def change
    create_table :mockupapps do |t|
      t.string :esearch
      t.string :regulatory_focus
      t.integer :apporder
      t.string :appname
			t.text :description
			t.text :icon
			t.text :screenshot1
			t.text :screenshot2
			t.text :screenshot3
      t.float :averagerating
      t.integer :totalrating
      t.string :distribution
      t.integer :num_star5
      t.integer :num_star4
      t.integer :num_star3
      t.integer :num_star2
      t.integer :num_star1
      t.float :pct_star5
      t.float :pct_star4
      t.float :pct_star3
      t.float :pct_star2
      t.float :pct_star1
      t.string :price
      t.string :revieworder

      t.references :subjectinfo

      t.timestamps
    end
  end
end
