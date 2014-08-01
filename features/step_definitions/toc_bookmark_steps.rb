When(/^student open Bookmark icon from toc$/) do
book.open_bookmark_toc
end

Then(/^the list of bookmark pages link should be open$/) do
  puts book.is_bookmark_list
end

Then(/^I press Edit title$/) do
book.open_edit_title
end

Then(/^I update the title "(.*?)"$/) do |text|
book.update_title text
end

Then(/^I press Save title$/) do
book.save_title
end

Then(/^I should be able to see the updated title$/) do
puts book.updated?
end

And /^I press Revove title$/ do
book.remove_bookmark
end

Then /^the Bookmark should be removed in the list$/ do
puts book.is_remove_bookmark
end