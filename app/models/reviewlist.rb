class Reviewlist < ActiveRecord::Base
  attr_accessible :appname, :star, :title, :author, :content, :date, :country, :version
end
