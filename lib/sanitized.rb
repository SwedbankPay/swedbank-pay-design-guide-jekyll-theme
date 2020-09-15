# frozen_string_literal: true

# The String class
class String
  # Sanitizes a filename
  def sanitized
    sanitized_filename = match(/(?m)(?<=\b_site).*$/)[0]
    sanitized_filename = sanitized_filename.gsub('index.html', '')
    sanitized_filename.gsub('.html', '')
  end
end
