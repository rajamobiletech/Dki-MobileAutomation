Given /^that "(.*?)" page of the book is displayed$/ do |page_number|
  @book_data.current_page = page_number.to_i
  book.navigate_to_page(@book_data.current_page)
end

Then /^student should see page number "(.*?)"$/ do |page_number|
  screenshot_and_raise "Page number is not matching" unless book.get_page_number == page_number.to_i
end

Given /^that student open any page in the selected book$/ do
  @book_data.current_page = 5 + rand(7)
  book.navigate_to_page(@book_data.current_page)
  @book_data.current_title=book.page_title
end

Then /^verify the page number is (\d+)$/ do |number|
  screenshot_and_raise "Page number is not matching" unless book.get_page_number == number
end

When /^student rotate device left$/ do
  steps %Q{When I rotate device left}
  sleep(STEP_PAUSE)
  @rotate=true
end

When /^student rotate device right$/ do
  steps %Q{When I rotate device right}
  sleep(STEP_PAUSE)
  @rotate=false
end

Then /^student should see the same page$/ do
  unless book.page_title.empty?
   screenshot_and_raise "Page title is not matching #{book.page_title} but expected - #{@book_data.current_title}" unless  @book_data.current_title.strip == book.page_title.strip
  end
  screenshot_and_raise "Page number is not matching" unless book.get_page_number == @book_data.current_page
end

When /^I press "(.*?)" button$/ do |button_name|
  sleep(1)
  home.login
end

Given /^I am on the Welcome Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end

When /^(?:|student )(?:|I )turn next page$/ do
  book.turn_next
end

When /^(?:|student )(?:|I )turn previous page$/ do
  book.turn_previous
end

Then /^I wait to see the title "(.*?)"$/ do |title|
  screenshot_and_raise "Title is not matching #{titleDiv["textContent"]}" unless book.page_title.eql?(title)
end


Then /^I wait to see the containerTitle "(.*?)"$/ do |title|
  screenshot_and_raise "Title is not matching #{titleDiv["textContent"]}" unless book.container_title.eql?(title)
end


When /^I turn to the page with title "(.*?)"$/ do |title|
  book.turn_to_page(title)
end


When /^I (\d+) pages faster$/ do |pages|
  pages.to_i.times do
    book.turn_faster
  end
end

When /^(?:|student)(?:|user) go back to Library$/ do
  book.go_to_library
  sleep(STEP_PAUSE + STEP_PAUSE)
end

When /^student tap end of the slider$/ do
  @book_data.current_page=book.get_page_number(false)
  book.move_slider_to_end
end

When /^student tap beginning of the slider$/ do
  @book_data.current_page=book.get_page_number(false)
  book.move_slider_to_begin
end

Then /^the page number should be increased$/ do
   screenshot_and_raise "The page number is not increased" unless @book_data.current_page < book.get_page_number
end

Then /^the page number should be decreased$/ do
   screenshot_and_raise "The page number is not decreased" unless @book_data.current_page > book.get_page_number
end
