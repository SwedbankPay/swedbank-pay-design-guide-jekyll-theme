# frozen_string_literal: true

RSpec::Matchers.define :be_string do |expected|
  match do |object|
    if object.nil?
      return true if expected.nil?

      return false
    end

    return false unless object.respond_to? :to_s

    object.to_s == expected
  end

  failure_message do |actual|
    "expected #{actual}#to_s to be equal to #{expected}"
  end

  description do
    'have a #to_s returning a string'
  end
end
