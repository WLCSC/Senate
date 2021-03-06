module ApplicationHelper
	include ActsAsTaggableOn::TagsHelper
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
		r << '<div class="tab-content" style="border: thin inset black; margin-top: 0px; background-color: #fff; padding: 5px;">'
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

	def can(right,securable=nil,user=nil)
		raise 'outside of securable resource' if (@chamber == nil && @ballot == nil && @proposal == nil && @board == nil && @securable == nil && securable == nil)
		raise 'no user supplied' if (user == nil && current_user == nil)
		
		x = (securable || @ballot || @proposal || @board || @securable || @chamber || @announcement).can?(user || current_user, right)
		return '*' if !x && current_user.admin?
		x
	end

	def can? right
		can right
	end


	def truthy_thumb(value)
		if value=="*"
			i('star').html_safe
		elsif value
			i('thumbs-up').html_safe
		else
			i('thumbs-down').html_safe
		end
	end

	def a(condition)
		return '*' if current_user && current_user.admin? && !condition
		condition		 
	end

	def i(c,w=false)
		('<i class="icon-' + c + (w ? " icon-white " : '') + '"></i>').html_safe
	end

	def markdown(text)
		sanitize(BlueCloth::new(text).to_html)
	end

	def nested_comments comments, rev=false, depth=1
		set = []
		if rev
			set = comments.sort{|a,b| a.created_at <=> b.created_at}	
		else
			set = comments.sort{|a,b| b.created_at <=> a.created_at}	
		end
	set.map do |comment|
		if comment != nil
		render(:partial => 'comments/comment', :locals => {:item => comment, :parent => false, :depth => (depth > 4 ? comment.count_children-1 : nil)}) + (depth > 4 || comment.comments.length == 0 ? "" : content_tag(:div, nested_comments(comment.comments,true,depth+1), :class => 'nested_comment'))
		end
	end.join.html_safe if comments.is_a? Array
	
  end

	def nice_date d
	d.strftime("%A, %B %d, %Y")
  end

  def nice_datetime d
	d.strftime("%I:%M %p %m-%d-%Y")
  end

	def recurse_assemblies assembly, chambers = false
		buf = "<ul>\n"
		if assembly.chambers.count > 0 && chambers
			assembly.chambers.each do |chamber|
				if chambers == "long"
					buf << render(:partial => 'chambers/chamber', :locals => {:item => chamber})
				else
					buf << render(:partial => 'chambers/short_chamber', :locals => {:item => chamber})
				end
			end
		end
		assembly.assemblies.each do |a|
			buf << "<li>" + link_to(a.name, a) + "</li>"
			if a.assemblies.count > 0 || (a.chambers.count > 0 && chambers)
				buf << recurse_assemblies(a, chambers ? true : false)
			end
		end
		
		buf << "</ul>"
		buf.html_safe
	end

	def tagbox item 
		buffer = '<div class="well" style="min-height: 5px; padding: 5px; padding-bottom: 0px;">' + "\n"
		tag_cloud(item.tag_counts_on(:tags), %w(css1 css2 css3 css4)) do |tag, css_class| 
			buffer << link_to(tag.name, tagged_path(:tag => tag.name), :class => css_class) + " "
			buffer << link_to((' ' + i('remove')).html_safe, untag_path(:tag => tag.name)+'?model='+item.class.to_s+'&id='+item.id.to_s) + " " if can(:admin)
		end
	
		if can(:write)
		buffer << '<h4>Add a Tag</h4>'
		buffer << form_tag(tag_path) do
			[
				hidden_field_tag(:model, item.class.to_s),
				hidden_field_tag(:id, item.id),
				text_field_tag(:tag),
				submit_tag("Add Tag")
			].join.html_safe
		end
		end

		buffer << "</div>"

		buffer.html_safe
	end

	def pills_for collection, klass = nil
		buffer = '<ul class="nav nav-pills ' + (klass ? klass : '') + '">' + "\n"
		collection.each do |item|
			buffer << '<li>' + link_to(item.display, item) + '</li>' + "\n"
		end
		buffer << '</ul>'
		buffer.html_safe
	end

	def log_box log, chamber=true
		if log.action_item
			begin
		lpath = log.action_item.is_a?(Chamber) ? log.action_item : [log.chamber, log.action_item]
		ltext = ((log.action_item && log.action_item.display) ? (log.comment + ', ' + log.action_item.display) : log.comment).gsub('.', '')
		buffer = '<div class="well">'
		buffer <<  link_to(log.user.name, log.user) + " "
		buffer << (can(:read, log.action_item) ? link_to(ltext, lpath) : log.comment.gsub('.', '') )
		if log.action_item.is_a? Comment
			buffer << ' - ' + (can(:read, log.action_item.superparent) ? link_to(log.action_item.superparent.display, [log.chamber, log.action_item.superparent]) : log.action_item.superparent.display )

		end
		if chamber && log.chamber && !log.action_item.is_a?(Chamber)
			buffer << " in " 
			buffer << (can(:read, log.chamber) ? link_to(log.chamber.title, log.chamber) : log.chamber.title)
		end
		buffer << ' <span style="color: #666;">' + distance_of_time_in_words_to_now(log.created_at) + ' ago</span>'
		buffer << "</div>"
		buffer.html_safe
			rescue Exception => e
				if current_user.admin?
					('<div class="well">' + e.to_s + '</div>').html_safe
				else
					''
				end
			end
		else
			if current_user.admin?
					('<div class="well">' + log.id.to_s + ' - ' + (log.action_type ? log.action_type : "UNDEF") + ":#{log.action_id || 0}" + '[' + link_to(log.user.username, log.user) + ' ' + log.comment + ']' + '</div>').html_safe
				else
					''
				end
		end
	end
end
