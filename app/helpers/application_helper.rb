module ApplicationHelper
  def current_user  
    if session[:user_id]
		current_user ||= User.find(session[:user_id])
	else
		current_user = nil
		nil
	end
  end

  def tabify list
		r = '<ul class="nav nav-tabs">'
		active = true
		list.each_pair do |li, str|
			if content_for? li
				r << "
"
				if active
					r << '<li class="active"><a data-toggle="tab" href="#'+li.to_s+'">'+str+'</a></li>'
					active = false
				else
					r << '<li><a data-toggle="tab" href="#'+li.to_s+'">'+str+'</a></li>'
				end
			end
		end
		r << '</ul>'
		r << "

"
		r << '<div class="tab-content" style="border: thin inset black; margin-top: 0px; background-color: #ccc">'
		list.each_pair do |li, str|
			if content_for? li
				if !active
					r << '<div class="tab-pane active" id="'+li.to_s+'">'
					active = true
				else
					r << '<div class="tab-pane" id="'+li.to_s+'">'
				end
				r << "
"
				r << content_for(li)
				r << "
"
				r << '</div>'
				r << "
"
			end
		end
		r << '</div>'
		r.html_safe
	end

	def twitterized_type(type)
		case type
		when :alert
			"warning"
		when :error
			"error"
		when :notice
			"info"
		when :success
			"success"
		else
			type.to_s
		end
	end

	def time_delta time
		if time < Time.now
			distance_of_time_in_words_to_now(time) + " ago"
		else
			distance_of_time_in_words_to_now(time) + " from now"
		end
	end

	def can(right,queue=nil,user=nil)
		raise 'outside of queue' if (@ticketqueue == nil && queue == nil)
		raise 'no user supplied' if (user == nil && current_user == nil)
		return nil if (@ticketqueue == nil && queue == nil)
		x = (queue || @ticketqueue).secures(user || current_user)
		return nil unless x
		return x.can right
	end

	def can? right
		can right
	end

end
