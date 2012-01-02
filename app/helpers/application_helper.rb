require 'google_chart'

module ApplicationHelper
  def current_user  
    if session[:user_id]
		current_user ||= User.find(session[:user_id])
		if(session[:override])
			@override = true
			current_user.privilege = session[:override]
		else
			@override = false
		end
		current_user
	else
		current_user = nil
		nil
	end
  end 
  
  def nested_comments comments, rev=true, depth=1
	return comments.sort{|a,b| rev ? b.created_at <=> a.created_at : a.created_at <=> b.created_at}.map do |comment|
		render(:partial => 'comments/comment', :locals => {:item => comment, :depth => (depth > 4 ? comment.count_children-1 : nil)}) + (depth > 4 ? "" : content_tag(:div, nested_comments(comment.comments,false,depth+1), :class => 'nested_comment'))
	end.join.html_safe if comments.is_a? Array
	
  end
  
  def can(right,chamber=nil,user=nil)
	raise 'outside of chamber' if (@chamber == nil && chamber == nil)
	raise 'no user supplied' if (user == nil && current_user == nil)
	return nil if (@chamber == nil && chamber == nil)
	return chamber.authoritate(current_user).can right if chamber
	@chamber.authoritate(current_user).can right
  end
  
  def can? right
	can right
  end
  
  def proposal_chart proposal
	chart = GoogleChart::PieChart.new('325x75', '', false)
	chart.fill :background, :solid, {:color => 'FFEFC4'}
	chart.data "Thumbs Up [#{proposal.positive}]", proposal.positive, '00ff00'
	chart.data "Thumbs Down [#{proposal.negative}]", proposal.negative, 'ff0000'
	chart.to_url
  end
  
  def ballot_chart ballot
	chart = GoogleChart::PieChart.new('325x75', '', false)
	chart.fill :background, :solid, {:color => 'FFEFC4'}
	
	totals = {}
	item.remarks.each do |remark|
		totals[remark.remark] ? totals[remark.remark] += 1 : totals[remark.remark] = 1
	end
	totals = totals.sort{|a,b| b[1] <=> a[1]}
	options = YAML.load(item.options).map{|x| x[1]}
	
	totals.each do |total|
		chart.data options[total[0]-1], total[1]
	end
	
	chart.to_url
  end
  
  def thumb val
	if val
		image_tag "thumbs-up.png"
	else
		image_tag "thumbs-down.png"
	end
  end
end