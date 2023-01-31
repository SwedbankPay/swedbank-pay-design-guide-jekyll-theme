# frozen_string_literal: true

require_relative 'support/verifier'
require_relative 'support/safe_strip'

Verifier = SwedbankPay::Verifier

describe Verifier do
  let(:dir) { File.expand_path(File.join(__dir__, '..', '_site')) }
  let(:auth_token) { ENV['GITHUB_TOKEN'].safe_strip }

  it 'has a GITHUB_TOKEN' do
    expect(auth_token).not_to be_nil || be_empty
  end

  it 'verifies the built site' do
    verifier = described_class.new(auth_token, log_level: :warn)
    expect { verifier.verify(dir) }.not_to raise_error
  end

  context 'with index.html' do
    subject { File.read(File.join(dir, 'index.html')) }

    it { is_expected.to include('"/assets/css/style.css"') }
  end
end
