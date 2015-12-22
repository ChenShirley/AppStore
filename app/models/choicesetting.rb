class Choicesetting < ActiveRecord::Base
  attr_accessible :regulatory_focus, :task, :task_appinfo, :task_apporder, 
									:appinfo_position, :apporder_position, :totalrating_position, :distribution_position
end
