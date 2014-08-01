When /^search for "(.*?)"$/ do |key|
  book.search(key)
end

When /^search for highlighted title$/ do
  book.search(@highted_title)
end

And /^verify the search result has current page$/ do
   screenshot_and_raise "Current page is not in the result" unless book.search_results.contains_title?(book.page_title)
end

Then /^I should see "(.*?)" page in the result$/ do |title|
  screenshot_and_raise "Page '#{title}' not the search result" unless book.search_results.include_title?(title)
end

Then /^verify search result snippets contains "(.*?)"$/ do |content|
   screenshot_and_raise "Unable to find the snippet" unless book.search_results.all_contains?(content)
end

Then /^verify search result snippets contains highlighted title$/ do
   screenshot_and_raise "Unable to find the snippet" unless book.search_results.all_contains?(@highted_title)
end

Then /^verify search result snippets not contain highlighted title$/ do
   screenshot_and_raise "Able to find the snippet" if book.search_results.all_contains?(@highted_title)
end

Then /^verify search result snippets not contains "(.*?)"$/ do |content|
   screenshot_and_raise "Snippet is present" if book.search_results.all_contains?(content)
end

Then /^verify search result snippets not contains highlighted title$/ do
   screenshot_and_raise "Snippet is present" if book.search_results.all_contains?(@highted_title)
end

Then /^verify search result is empty$/ do
  screenshot_and_raise "Search result is not empty" unless book.search_results.empty?
end

Then /^select page "(.*?)" from result$/ do |title|
  book.search_results.select_page(title)
end

When /^student select a page from the result$/ do
  page_index = rand(6)
  @book_data.current_page = book.search_results.get_page_number(page_index).to_i
  @book_data.current_title = book.search_results.get_page_title(page_index)
  book.search_results.select_result(page_index)
  sleep(STEP_PAUSE+STEP_PAUSE)
end


And /^filter result to "(.*?)"$/ do |filter|
  book.search_results.filter_result(filter)
end

When /^student search for a key$/ do
  unless @searched
    book.go_to_library
    sleep(15) # for a newly opened book the search index will take time
    steps %Q{Then student open the book}
    @searched = true
  end
  book.search(@book_data.searchkey)
end

When /^student search for a partial key$/ do
  book.search(@book_data.searchkey[1..-2])
end

Then /^search result should not be empty$/ do
  screenshot_and_raise "Search result is empty" if book.search_results.empty?
end

And /^search result snippets contains the key$/ do
  steps %Q{Then verify search result snippets contains "#{@book_data.searchkey}"}
end
