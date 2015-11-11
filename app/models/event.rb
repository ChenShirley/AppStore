class Event < ActiveRecord::Base
  attr_accessible :esearch, :regulatory_focus, :appname, :apporder, :review, :detail, :purchase, :clickorder
	# :access_time, :leave_time
end
