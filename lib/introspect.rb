require 'highline'

module Introspect
	def Introspect::peek(obj)
		s = obj.public_methods - Object.public_methods
		Introspect::tableize(s.sort)
	end
	
	def Introspect::objpeek
		s = Object.public_methods
		Introspect::tableize(s.sort)
	end
	
	def Introspect::delve(enum,l=0)
		#puts 'delving into ' + enum.inspect + "@" + l.to_s
		if enum.is_a? Enumerable
			if enum.is_a? Hash
				puts ("  "*l ) + enum.class.to_s
				enum.each do |k,v|
					puts ("  "*(l+1) ) + k.inspect + " (#{k.class})" + " => " + v.inspect + " (#{v.class})"
					delve(v,l+2) if v.is_a? Enumerable
				end	
			else
				puts ("  "*l ) + enum.class.to_s
				enum.each do |e|
					delve(e,l+1)
				end
			end
		else
			puts ("  "*l ) + ">>#{enum.inspect}"
		end
	end
	
	def Introspect::state(obj)
		puts "State of #{obj.inspect} (#{obj.class})"
		if obj.respond_to?('instance_variables') && obj.instance_variables.length >= 1 
			puts "Instance Variables:"
			obj.instance_variables.each do |v|
				puts "  #{v} = #{obj.instance_eval v}"
			end
			puts
		end
		
		if obj.respond_to?('class_variables') && obj.class_variables.length >= 1 
			puts "Class Variables:"
			obj.class_variables.each do |v|
				puts "  #{v} = #{obj.instance_eval v}"
			end
			puts
		end
		
		if obj.is_a? Enumerable
			puts "Delving in"
			Introspect::delve(obj)
		end
		
	end
	
	def Introspect::is_there o,a
		s = []
		o.public_methods.each do |m|
			s << m.to_s.gsub(' ','_') if m.to_s.match(a)
		end
		
		if s == nil
			puts "No, there's not."
		else
			puts "Yes, there #{ (s.length == 1) ? 'is' : 'are'} #{s.length}."
			s
		end
		
	end
	
	def Introspect::tableize(arr,width=nil,pad=1)
		max = 0
		arr.map! do |x|
			if(x==nil)
				" "
			else
				x
			end
		end
		arr.each do |s|
			#puts "MAX Reset w/ #{s}" if s.length > max
			max = s.length if s.length > max
		end
		
		max += 2*pad
		#puts "MAX:#{max}"
		
		cols = HighLine.new.output_cols
		width = width || (cols / (max+1.0)).floor
		#puts "WIDTH:#{width}"
		height = (arr.length / width.to_f).ceil
		#puts "HEIGHT:#{height}"
		
		height.times do |h|
			width.times do |w|
				print arr[(h)*width + w].to_s.center(max) + '|'
			end
			puts
		end
	end
	
	def peek
		Introspect::peek self
	end
	
	def delve
		Introspect::delve self
	end
	
	def is_there a
		Introspect::is_there self, a
	end
	
	def state
		Introspect::state self
	end
	
	def tableize(width=nil,pad=1)
		Introspect::tableize(self.to_a,width,pad)
	end
end