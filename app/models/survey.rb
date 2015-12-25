class Survey < ActiveRecord::Base
	validates_presence_of :age, :gender, :income, :involvement1, :involvement2, :involvement3, :rf1, :rf2, :rf3, :rf4, :rf5, :rf6, :rf7,
												:why, :attention
  validates :age, numericality: { only_integer: true }
  attr_accessible :esearch, :regulatory_focus,
									:age, :gender, :income,
									:involvement1, :involvement2, :involvement3, 
									:rf1, :rf2, :rf3, :rf4, :rf5, :rf6, :rf7,
									:why, :suggestion, :attention,
									:end_time
end
