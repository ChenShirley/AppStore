class Choicesetting < ActiveRecord::Base
  attr_accessible :task, :task_appinfo, :task_apporder, 
									:appinfo_position, :apporder_position, :totalrating_position, :distribution_position
end
