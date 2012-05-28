module CommentableModel
	def count_children
		t = 1
		self.comments.each do |c|
			t += c.count_children
		end
		t
	end

	def is_commentable?
		true
	end
end
