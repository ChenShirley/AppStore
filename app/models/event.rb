class Event < ActiveRecord::Base
  attr_accessible :esearch, :regulatory_focus, :apporder, :appname, :review, :detail, :purchase, :access_time, :leave_time
end
