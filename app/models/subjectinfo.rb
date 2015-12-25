class Subjectinfo < ActiveRecord::Base
	validates_presence_of :mobile_user, :appstore, :visit_frequency, :app_expense, :previous_experience
  attr_accessible :esearch, :regulatory_focus, :mobile_user, :appstore, :visit_frequency, :app_expense, :previous_experience,
									:ip_address, :start_time, :browser, :browser_version, :platform, :os,
									:mturk_surveycode, :choiceset_receipt, :choiceset_rep, :choicesetting_id
	belongs_to :choicesetting
end
