# frozen_string_literal: true

class Object
  def safe_strip
    return self if nil? || !is_a?(String)

    strip
  end
end
