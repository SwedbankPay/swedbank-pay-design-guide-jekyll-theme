# frozen_string_literal: true

# The Hash class
class Hash
  # Safely merges the current Hash with an 'other' Hash.
  def safe_merge(other)
    all_keys = keys | other.keys
    result_hash = {}

    all_keys.each do |key|
      hash_value = {}

      if key? key
        value = self[key]
        hash_value = value unless value.nil?
      end

      if other.key? key
        value = other[key]
        hash_value = hash_value.merge(value) unless value.nil?
      end

      result_hash[key] = hash_value
    end

    result_hash
  end
end
