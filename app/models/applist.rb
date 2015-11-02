class Applist < ActiveRecord::Base
  attr_accessible :link, :appname, :icon, :store, :price,
									:description, :country,
									:average_current, :total_current, :average_all, :total_all, 
									:current1, :current2, :current3, :current4, :current5,
									:all1, :all2, :all3, :all4, :all5,
									:compatibility, :category, :updated_date, :size, :seller, :rated, :requirements, :bundleid,
									:screenshot1, :screenshot2, :screenshot3
end
