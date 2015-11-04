class CreateMockupreviews < ActiveRecord::Migration
  def change
    create_table :mockupreviews do |t|
      t.string :esearch
      t.integer :apporder
      t.string :appname
      t.integer :revieworder
      t.integer :star
      t.text :title
      t.text :author
      t.text :content
      t.string :date

      t.references :mockupapp

      t.timestamps
    end
  end
end
