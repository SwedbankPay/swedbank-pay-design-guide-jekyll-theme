# frozen_string_literal: true

require 'liquid'
require 'read_time_filter'

describe SwedbankPay::ReadTimeFilter do
  subject { Liquid::Template.parse(" {{ '#{content}' | read_time }} ").render({}, filters: [described_class]) }

  let(:content) { nil }

  context 'when given a nil string' do
    it { is_expected.to eq(' 0 min read ') }
  end

  context 'when given a short string' do
    let(:content) { 'short string' }

    it { is_expected.to eq(' 1 min read ') }
  end

  context 'when given a long string' do
    let(:content) { 'lorem ipsum' * 5000 }

    it { is_expected.to eq(' 21 min read ') }
  end
end
