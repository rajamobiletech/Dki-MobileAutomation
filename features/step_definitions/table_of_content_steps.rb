When /^student press on the table of content button in the header$/ do
  book.open_toc
end

Then /^table of content should display in the page$/ do
  screenshot_and_raise "Table of content is not displayed" unless book.toc_displayed?
end

When /^student press on resume reading$/ do
  book.press_resume_reading
end

When /^user navigated to any page from toc$/ do
  @book_data.current_page= 1 + rand(10)
  @book_data.current_title=book.get_page(@book_data.current_page)
  book.select_page(@book_data.current_page)
end

Then /^the table of content should be hidden$/ do
  screenshot_and_raise "Table of content is displayed" if book.toc_displayed?
end

Given /^student opened table of content$/ do
  steps %Q{When student press on the table of content button in the header
          Then table of content should display in the page}
end

When /^user select "(.*?)" from table of content$/ do |link|
  book.select_toc_item(link)
end

Given /^user is in the "(.*?)" page$/ do |page|
  steps %Q{When user opened table of content
           And user select "#{page}" from table of content}
end

When /^student navigated to no\-bookmarked page from toc$/ do
  @book_data.current_title=book.open_non_bookmarked_page
  book.select_toc_item(@book_data.current_title)
  @book_data.current_page = book.get_page_number
end

When /^student navigated to bookmarked page from toc$/ do
  @book_data.current_title = book.open_bookmarked_page
  book.select_toc_item(@book_data.current_title)
  @book_data.current_page = book.get_page_number
end
