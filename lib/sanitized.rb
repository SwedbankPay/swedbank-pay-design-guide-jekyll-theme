# frozen_string_literal: true

# The String class
class String
  # Sanitizes a filename
  def sanitized
    match = match(/(?m)(?<=\b_site).*$/)
    sanitized_filename = match ? match[0] : self
    sanitized_filename = sanitized_filename.gsub('index.html', '')
    sanitized_filename.gsub('.html', '')
  end
end
