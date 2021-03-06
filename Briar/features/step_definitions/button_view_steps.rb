When(/^I touch the "([^"]*)" button I should see an (action sheet|alert|email compose view)$/) do |button_id, what|

  if what.eql?('action sheet')
    touch_button_and_wait_for_view button_id, 'sheet'
  elsif what.eql?('alert')
    touch_button_and_wait_for_view button_id, 'Briar Alert!'
  elsif what.eql?('email compose view')
    if device_configured_for_email
      touch_button_and_wait_for_view button_id, 'compose email'
    else
      warn 'this device is not configured for email - this is not optimal because it will not test all features'
      touch_button_and_wait_for_view button_id, 'No Mail Accounts'
    end
  end
  step_pause
end

Then(/^I dismiss the (action sheet|alert|email compose view) with the cancel button$/) do |what|

  if what.eql?('action sheet')
    if ipad?
      touch_sheet_button 'Delete', 'sheet'
    else
      touch_sheet_button 'Cancel', 'sheet'
    end
    wait_for_view_to_disappear 'sheet'
  elsif what.eql?('alert')
    touch_alert_button 'Cancel'
  elsif what.eql?('email compose view')
    if device_configured_for_email
      delete_draft_and_wait_for 'buttons'
    else
      touch("view marked:'OK'")
      wait_for_view 'buttons'
    end
  end
end
