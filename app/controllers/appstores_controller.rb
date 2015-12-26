class AppstoresController < ApplicationController

	def random_barchart(num, a1, a2, b1, b2 ,c1, c2, d1, d2, e1, e2)
		a = a1+Random.rand(a2-a1)
		b = b1+Random.rand(b2-b1)
		c = c1+Random.rand(c2-c1)
		d = d1+Random.rand(d2-d1)
		e = e1+Random.rand(e2-e1)
		@bar5 = (num*((a.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		@bar4 = (num*((b.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		@bar3 = (num*((c.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		@bar2 = (num*((d.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		@bar1 = (num*((e.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		if (@bar5+@bar4+@bar3+@bar2+@bar1)!=num
				@bar2 = (num-(@bar5+@bar4+@bar3+@bar1)).round
		end
		if @bar2<0
			random_barchart(num, a1, a2, b1, b2 ,c1, c2, d1, d2, e1, e2)
		elsif @bar2 > @bar1 && @bar2 > @bar3
			random_barchart(num, a1, a2, b1, b2 ,c1, c2, d1, d2, e1, e2)
		elsif @bar3 > @bar2 && @bar3 > @bar4
			random_barchart(num, a1, a2, b1, b2 ,c1, c2, d1, d2, e1, e2)
		elsif @bar5>=1 && @bar4>=1 && @bar3>=1 && @bar2>=1 && @bar1>=1	# to display reviews, each star at least 1
			@pct5 = (@bar5.fdiv(num)*100).round(1)
			@pct4 = (@bar4.fdiv(num)*100).round(1)
			@pct3 = (@bar3.fdiv(num)*100).round(1)
			@pct2 = (@bar2.fdiv(num)*100).round(1)
			@pct1 = (@bar1.fdiv(num)*100).round(1)
			return @pct5, @pct4, @pct3, @pct2, @pct1, @bar5, @bar4, @bar3, @bar2, @bar1
		else
			random_barchart(num, a1, a2, b1, b2 ,c1, c2, d1, d2, e1, e2)
		end
	end

	def index # survey introduction page
	end

	def new
  	@subject = Subjectinfo.new
	end

	def create
		@subject = Subjectinfo.new(params[:subjectinfo])

		@subject_mobile = params[:subjectinfo][:mobile_user]
		@subject_visit = params[:subjectinfo][:visit_frequency]
		@subject_previous = params[:subjectinfo][:previous_experience]
		
		# terminate, not mobile user, unknow visit frequency, expert in health & fitness
		if (@subject_mobile=="0" ||  (@subject_visit=="5" || @subject_visit=="6") || (@subject_previous=="7"))
			flash[:notice] = "We’re sorry. You do not meet the qualifications for this survey. We are seeking respondents who are mobile device user AND have experience of using app store. We sincerely thank you and appreciate your time, dedication, and continued participation in our online surveys."
			redirect_to :action => :index and return
		else
			@subject.save
		end

		if @subject.save

			@subject_esearch = params[:subjectinfo][:esearch]
			@subject_id = Subjectinfo.find_by_esearch(@subject_esearch)

		# random give choice set for now
			@choiceset_id = 1 + Random.rand(143)
		# call function from ChoiceSetService
		# @choiceset_queue = ChoiceSetService.new.start_choiceset
		# @choiceset_id = @choiceset_queue.configuration
		# @choiceset_rep = @choiceset_queue.repetition
		# @choiceset_receipt = @choiceset_queue.receipt
		# subject_id.update_attributes!(:choiceset_receipt => @choiceset_receipt, :choicesetting_id => @choiceset_id, :choiceset_rep => @choiceset_rep)

			@choiceset = Choicesetting.find(@choiceset_id)

		# create random sequences
		# regulatory focus, 1 for promotion, 2 for prevention
		@rf_sequence = @choiceset.regulatory_focus

		# appinfo
		@appinfo_sequence = @choiceset.appinfo_position

		# apporder
		@apporder_sequence = @choiceset.apporder_position

		# number of ratings, 1 for 20-50, 2 for 1000-5000
		# @num_sequence = [0,0,1,1].shuffle
		@num_sequence = @choiceset.totalrating_position

		# rating distribution shape, 1 for J shaped, 2 for U shaped
		# @distr_sequence = [0,0,1,1].shuffle
		@distr_sequence = @choiceset.distribution_position

		# create random content and store to database
		# regulatory focus
		if @rf_sequence == "1"
			@subject_id.update_attributes!(:choicesetting_id => @choiceset_id, :regulatory_focus => "promotion")
			@rf = "promotion"
		elsif @rf_sequence == "2"
			@subject_id.update_attributes!(:choicesetting_id => @choiceset_id, :regulatory_focus => "prevention")
			@rf = "prevention"
		end

		(0..3).each do |i|	# count 4 app
			@appinfo = Applist.find(@appinfo_sequence[2*i])

			# number of ratings
			if @num_sequence[2*i] == "1"
				@num = 20 + Random.rand(30)
			elsif @num_sequence[2*i] == "2"
				@num = 1000 + Random.rand(4000)
			end

			# rating distribution shape
			# rating distribution shape detail, 3 shapes for J or U
			if @distr_sequence[2*i] == "1"
				@distr = "J"
				@pct_star5, @pct_star4, @pct_star3, @pct_star2, @pct_star1, @bar_star5, @bar_star4, @bar_star3, @bar_star2, @bar_star1 = random_barchart(@num, 70, 90, 10, 50, 5, 10, 1, 10, 5, 15)
			elsif @distr_sequence[2*i] == "2"
				@distr = "U"
				@pct_star5, @pct_star4, @pct_star3, @pct_star2, @pct_star1, @bar_star5, @bar_star4, @bar_star3, @bar_star2, @bar_star1 = random_barchart(@num, 70, 90, 5, 35, 5, 15, 1, 15, 65, 75)
			end

			# calculate average rating
			@average = ((5*@bar_star5 + 4*@bar_star4 + 3*@bar_star3 + 2*@bar_star2 + 1*@bar_star1).fdiv(@num)).round(1)

			Mockupapp.create(:esearch => @subject_esearch, :regulatory_focus => @rf,
										:apporder => @apporder_sequence[2*i], :appname => @appinfo.appname, :description => @appinfo.description,
										:icon => @appinfo.icon,
										:screenshot1 => @appinfo.screenshot1, :screenshot2 => @appinfo.screenshot2, :screenshot3 => @appinfo.screenshot3,
										:averagerating => @average, :totalrating => @num, :distribution => @distr,
										:num_star5 => @bar_star5, :num_star4 => @bar_star4, :num_star3 => @bar_star3,
										:num_star2 => @bar_star2, :num_star1 => @bar_star1,
										:pct_star5 => @pct_star5, :pct_star4 => @pct_star4, :pct_star3 => @pct_star3,
										:pct_star2 => @pct_star2, :pct_star1 => @pct_star1,
										:price => "0.99", :subjectinfo_id => @subject_id.id)

			Event.create(:esearch => @subject_esearch, :regulatory_focus => @rf, :appname => @appinfo.appname,
									 :apporder => @apporder_sequence[2*i],
									 :review => 0, :detail => 0, :purchase => 0, :clickorder => "")
		end # end for loop


		# app reviews
		# review_star_sequence[4][0] is star5 refer to (review_star_sequence[4][0])-th review
		@review_star_sequence = [[1,2,3,4].shuffle,[1,2,3,4].shuffle,[1,2,3,4].shuffle,[1,2,3,4].shuffle,[1,2,3,4].shuffle]

		for i in 0..3	# select which to be the (i+1)-th, (i+1) is app order
			#@app = Mockupapp.where("esearch=? AND apporder=?",@subject_esearch,i+1)
			@app_order = i+1
			@app = Mockupapp.find_by_esearch(@subject_esearch, :conditions => "apporder = #{@app_order}")
			for j in 0..4
				review_star = Reviewlist.where("star=?",j+1)
				# there are review_star[0] - review_star[7]
				@review = review_star[@review_star_sequence[j][i]-1]
				if @app.revieworder.blank?
					@app.update_attributes!(:revieworder => @review.id.to_s)
				else
					@app.update_attributes!(:revieworder => (@app.revieworder.to_s + "," + @review.id.to_s))
				end
			end # end for loop j
		end # end for loop i

		  redirect_to :action => "rfscenario", :esearch => @subject_esearch
		else # not pass DB validation
		  render :action => :new # might have problem on view's radio checkbox
		end
	end

	def rfscenario
		@subject_esearch = params[:esearch]
		@subject = Subjectinfo.find_by_esearch(@subject_esearch)
	end

	def apps
		@subject_esearch = params[:esearch]
		@app = Mockupapp.where(:esearch => @subject_esearch)
		# track where user come back from, only work with "back to appstore button", not work with browser's back button
=begin
		if Event.find_by_esearch(@subject_esearch).present?
			@lastevent = Event.where(:esearch=>@subject_esearch).order("id").last
			@lastevent.update_attributes!(:leave_time => Time.now)
		end
=end
	end

	def detail
		@subject_esearch = params[:esearch]
		@app_order = params[:apporder]
		@app = Mockupapp.find_by_esearch(@subject_esearch, :conditions => "apporder = #{@app_order}")
		# track everytime user click the read details button
		@lastevent = Event.find_by_esearch(@subject_esearch, :conditions => "appname = '#{@app.appname}'")
		@lastevent.update_attributes!(:detail => (1+@lastevent.detail.to_i), :clickorder => (@lastevent.clickorder.to_s + "d"))
	end

	def review
		@subject_esearch = params[:esearch]
		@app_order = params[:apporder]
		@app = Mockupapp.find_by_esearch(@subject_esearch, :conditions => "apporder = #{@app_order}")
		@revieworder = @app.revieworder.split(',')
		@appreview= Reviewlist.where("id=? OR id=? OR id=? OR id=? OR id=?", @revieworder[0], @revieworder[1], @revieworder[2], @revieworder[3], @revieworder[4])

		# track everytime user click the read reviews button
		@lastevent = Event.find_by_esearch(@subject_esearch, :conditions => "appname = '#{@app.appname}'")
		@lastevent.update_attributes!(:review => 1+@lastevent.review.to_i, :clickorder => @lastevent.clickorder.to_s + "r")
	end

	def survey
		@subject_esearch = params[:esearch]
		@app_order = params[:apporder]
		@app = Mockupapp.find_by_esearch(@subject_esearch, :conditions => "apporder = #{@app_order}")
		# track everytime user click the purchase button
		@lastevent = Event.find_by_esearch(@subject_esearch, :conditions => "appname = '#{@app.appname}'")
		@lastevent.update_attributes!(:purchase => 1+@lastevent.purchase.to_i, :clickorder => @lastevent.clickorder.to_s + "p")

		@esearch = Subjectinfo.find_by_esearch(@subject_esearch)
  	@subject = Survey.new
	end

	def endsurvey
		@esearch = Subjectinfo.find_by_esearch(params[:survey][:esearch])

		@subject = Survey.new(params[:survey])
		@subject.save
		if @subject.save
			## after user has finished experiment, check respondent valid or not. if yes, close choiceset
			# if (@subject.end_time - @esearch.start_time) > 180 # 3 minutes
			# receipt = @esearch.choiceset_receipt
			# ChoiceSetService.new.close_choiceset(receipt)
			# else
			# end

			surveycode = "#{@esearch.choicesetting_id}" + "T" + "#{Time.now.to_i}"
			@esearch.update_attributes!(:mturk_surveycode => surveycode)

			flash[:notice] = "Your response has been recorded."
		  render :action => "thankyou", :esearch => params[:survey][:esearch]
		else # not pass DB validation
		  render :action => :survey, :esearch => params[:survey][:esearch]
		end
	end

	def thankyou
		@esearch = Subjectinfo.find_by_esearch(params[:survey][:esearch])
	end

end
