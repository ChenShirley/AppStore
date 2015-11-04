class Subjectinfo < ActiveRecord::Base
	validates_presence_of :esearch, :mobile_user, :appstore, :visit_frequency, :app_expense, :previous_experience
  attr_accessible :esearch, :regulatory_focus, :mobile_user, :appstore, :visit_frequency, :app_expense, :previous_experience,
									:ip_address, :start_time
end
