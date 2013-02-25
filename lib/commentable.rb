module CommentableModel
	def count_children 
		t = 0 
		self.comments.each do |c|
			t += 1
			t += c.count_children
		end
		t
	end

	def is_commentable?
		true
	end
end
