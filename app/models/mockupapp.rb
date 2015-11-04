class Mockupapp < ActiveRecord::Base
  attr_accessible :esearch, :regulatory_focus, :apporder, :appname, :description, :icon,
									:screenshot1, :screenshot2, :screenshot3,
									:averagerating, :totalrating, :distribution,
									:num_star5, :num_star4, :num_star3,
									:num_star2, :num_star1,
									:pct_star5, :pct_star4, :pct_star3,
									:pct_star2, :pct_star1,
									:price,
									:subjectinfo_id
	belongs_to :subjectinfo
end
