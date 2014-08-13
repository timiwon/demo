module ApplicationHelper
	def FullTitle(page_title)
		base_title = "Title"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end

	end
end
