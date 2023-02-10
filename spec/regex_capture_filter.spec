# frozen_string_literal: true

require 'liquid'
require 'regex_capture_filter'

describe SwedbankPay::RegexCaptureFilter do
  subject { Liquid::Template.parse(" {{ '#{markup}' | regex_capture: 'id=\"([^\"]+)\"' | first }} ").render({}, filters: [described_class]) }

  let(:markup) { nil }

  context 'when given a nil string' do
    it { is_expected.to eq('  ') }
  end

  context 'when given HTML without match' do
    let(:markup) { 'lorem ipsum' }

    it { is_expected.to eq('  ') }
  end

  context 'when given HTML with match' do
    let(:markup) { '<h1 id="first-header">First header</h1>' }

    it { is_expected.to eq(' first-header ') }
  end
end
