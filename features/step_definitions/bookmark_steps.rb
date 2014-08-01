When /^(?:|student )taps the bookmark tag$/ do
  book.tap_bookmark
end

Then /^the page should be bookmarked$/ do
  screenshot_and_raise "The page is not bookmarked" unless book.page_bookmarked?
end


Given /^user bookmarked the page with title "(.*?)"$/ do |arg1|
  steps %Q{ Given I turn to the page with title "Command List"
            When taps the bookmark tag}
end

Then /^the page should not be bookmarked$/ do
  screenshot_and_raise "The page is bookmarked" if book.page_bookmarked?
end

Given /^that student open non bookmarked page$/ do
  if book.page_bookmarked?
    steps %Q{When taps the bookmark tag}
  end
end

Given /^that student open a bookmarked page$/ do
  unless book.page_bookmarked?
   steps %Q{When taps the bookmark tag}
  end
end
