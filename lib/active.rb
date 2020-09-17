# frozen_string_literal: true

# The String class
class String
  # Returns true if a filename should be considered active given the current URL;
  # otherwise false.
  def active?(url, exact: false)
    if self == '/' || url == '/'
      return true if self == '/' && url == '/'

      return false
    end

    exact ? self == url : start_with?(url)
  end
end
