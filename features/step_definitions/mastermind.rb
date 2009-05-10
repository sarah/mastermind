def messenger
  @messenger ||= StringIO.new
end

def game
  @game ||= Mastermind::Game.new(messenger)
end

def messages_should_include(message)
  messenger.string.split("\n").should include(message)
end

Given /^I am not yet playing$/ do
end

When /^I start a new game$/ do
  game.start(%w[r g y c])
end

Then /^the game should say "(.*)"$/ do |message|
  messages_should_include(message)
end

Given /^the secret code is (. . . .)$/ do |code|
  game.start(code.split)
end

When /^I guess (. . . .)$/ do |code|
  game.guess(code.split)
end

# This has no spaces -- combine with the one above that allows spaces so the regex takes both?
When /^I guess (....)$/ do |code|
  game.guess(code.split)
end

Then /^the mark should be (.*)$/ do |mark|
  messenger.string.split("\n").should include(mark)
end

# Game over guesses

Then /^the game should be over$/ do
  game.should be_over
end

Then /^I should see the message "([^\"]*)"$/ do |message|
  messages_should_include(message)
end

Then /^I should not see the message "([^\"]*)" again$/ do |message|
  messages = messenger.string.split("\n")
  messages.last.should_not == message
end


When /^I break the code in (.*) guesses$/ do |guess_count|
  game.start(%w[r g y c])
  (guess_count.to_i - 1).times do
    game.guess(%w[r g y b])
  end
  game.guess(%w[r g y c])
end

When /^I guess incorrectly 10 times$/ do
  game.start(%w[r g y c])
  10.times do
    game.guess(%w[r g y b])
  end
end

Given /^the game is over$/ do
  game.start(%w[r g y c])
  game.guess(%w[r g y c])
end

Given /^I choose (.*)$/ do |guess|
  game.guess([guess])
end