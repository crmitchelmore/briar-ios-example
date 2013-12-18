module Briar
  module Text_Related
    def swipe_on_text_field(dir, field)
      dev = device
      if dev.ios7? && dev.simulator?
        pending 'iOS 7 simulator detected: due to a bug in the iOS Simulator, swiping does not work'
      end
      tf = "#{field} tf"
      wait_for_view tf, 2
      swipe(dir, {:query => "textField marked:'#{tf}'"})
      2.times { step_pause }
      tf
    end
  end
end

World(Briar::Text_Related)

Then(/^I swipe (left|right) on the (top|bottom) text field$/) do |dir, field|
  swipe_on_text_field dir, field
end

Then(/^I should see the (top|bottom) text field has "([^"]*)"$/) do |field, text|
  tf = "#{field} tf"
  should_see_text_field_with_text tf, text
  warn "status bar orientation = '#{status_bar_orientation}'"
  2.times { step_pause }
end


When(/^I type an email into the text field it should appear correctly$/) do

end



Then(/^I type (\d+) email addresses into the text field$/) do |num|
  tf_id = 'top tf'
  touch("textField marked:'#{tf_id}'")
  await_keyboard

  num.to_i.times {
    email = ''
    50.enum_for(:times).inject(email) do |result, index|
      sample = [*32..126].sample.chr
      sample = '@' if sample.eql?('(') or sample.eql?(')')
      sample = '!' if sample.eql?(':')
      sample = '?' if sample.eql?(';')
      sample = '€' if sample.eql?('\\')
      sample = '?' if sample.eql?(',')
      email << sample
    end



    #email = Faker::Internet.email
    #tokens = email.split('@')
    #num = [*0..3030].sample
    #name = "#{tokens.first}#{num}".chars.shuffle().join('')
    #email = "#{name}@#{tokens[1]}"

    keyboard_enter_text email
    should_see_text_field_with_text tf_id, email
    clear_text("view marked:'#{tf_id}'")
    step_pause
  }
end