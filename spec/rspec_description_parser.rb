module RSpecDescriptionParser
    def parse_index(example)
        indices = {}

        group = example.metadata[:example_group]

        indices(group).each_with_index do |value, index|
            indices[index] = value
        end

        indices
    end

    private

    def indices(group)
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
