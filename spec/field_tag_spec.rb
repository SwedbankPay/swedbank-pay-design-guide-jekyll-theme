# frozen_string_literal: true

require 'its'
require 'liquid'
require 'field_tag'

describe SwedbankPay::FieldTag do
  subject(:date) { described_class.parse('f', input, nil, Liquid::ParseContext.new) }

  context 'with field name' do
    let(:input) { 'href' }

    its(:raw) { is_expected.to eq('f href') }

    its(:render, Liquid::Context.new) do
      is_expected.to eq('<span class="field-level field-level-1"><code class="language-json highlighter-rouge">href</code></span>')
    end
  end

  context 'with field name and level' do
    let(:input) { 'operations, 2' }

    its(:raw) { is_expected.to eq('f operations, 2') }

    its(:render, Liquid::Context.new) do
      is_expected.to eq('<span class="field-level field-level-2"><code class="language-json highlighter-rouge">operations</code></span>')
    end
  end

  context 'with invalid level' do
    let(:input) { 'operations, abc' }

    its(:raw) { is_expected.to eq('f operations, abc') }

    its(:render, Liquid::Context.new) do
      is_expected.to eq('<span class="field-level field-level-1"><code class="language-json highlighter-rouge">operations</code></span>')
    end
  end

  context 'with nil field name' do
    let(:input) { nil }

    its(:raw) { is_expected.to eq('f ') }

    its(:render, Liquid::Context.new) do
      is_expected.to eq('')
    end
  end

  context 'with empty field name and valid level' do
    let(:input) { ', 4' }

    its(:raw) { is_expected.to eq('f , 4') }

    its(:render, Liquid::Context.new) do
      is_expected.to eq('')
    end
  end
end
