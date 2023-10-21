module Matchers
  RSpec::Matchers.define :have_test_id do |test_id, on_element: "*"|
    match do |page|
      @element_exists = page.has_css?("#{on_element}[#{Capybara.test_id}='#{test_id}']", match: :first)
    end

    match_when_negated do |page|
      @element_does_not_exist = page.has_no_css?("#{on_element}[#{Capybara.test_id}='#{test_id}']", match: :first)
    end

    failure_message do |_page|
      "expected to find #{on_element} element with test_id '#{test_id}', but there was none."
    end

    failure_message_when_negated do |_page|
      "expected not to find #{on_element} element with test_id '#{test_id}', but it was found."
    end
  end
end
