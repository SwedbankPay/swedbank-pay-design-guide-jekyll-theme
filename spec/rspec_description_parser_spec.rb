# frozen_string_literal: true

require 'its'
require_relative 'rspec_description_parser'

describe RSpecDescriptionParser do
    describe '#parse_index' do
        ['[123]', 'something[123]', 'something[123].else', '[123].else'].each do |desc|
            context desc do
                subject { |x| parse_index(x) }

                it { is_expected.to be_an_instance_of Hash }
                its(:length) { is_expected.to eq 1 }
                it { is_expected.to have_key(0) }
                it { is_expected.to eq(0 => 123) }
            end
        end
    end
end
