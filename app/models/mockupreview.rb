class Mockupreview < ActiveRecord::Base
  attr_accessible :esearch, :apporder, :appname, :revieworder, :star, :title, :author, :content, :date, :mockupapp_id
	belongs_to :mockupapp
end
