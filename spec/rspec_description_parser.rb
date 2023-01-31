# frozen_string_literal: true

# Parses the description in `RSpec.describe` blocks and returns whatever integer
# it finds inside square brackets `[…]`.
module RSpecDescriptionParser
  def parse_index(example)
    indices = find_indices(example.metadata[:example_group])

    # Convert the indices to a Hash that has the position as the hash key
    # and the index value as the hash value.
    indices.size.times.zip(indices).to_h
  end

  private

  def find_indices(group)
    indices = []

    recurse(group, indices)

    indices.reverse
  end

  def recurse(group, indices)
    description = group[:description]
    index_value = parse(description)

    indices.push(index_value) unless index_value.nil?

    parent_group = group[:parent_example_group]

    recurse(parent_group, indices) unless parent_group.nil?
  end

  def parse(description)
    index_regex = /[^\[\]]*\[(\d+)\][^\[\]]*/
    match = index_regex.match(description)

    return nil if match.nil? || match.captures.nil? || match.captures.empty?

    match.captures.first.to_i
  end
end
