# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  after_payment_path = File.expand_path(File.join(@dest_dir, 'checkout', 'v2', 'after-payment.html'))

  describe after_payment_path do
    subject { File.read(after_payment_path) }

    it {
      expect(File).to exist(after_payment_path)
    }

    it 'has active item' do
      expect(subject).to have_tag('li.group.active') do
        with_tag('li.group.active') do
          with_tag('a[href="/checkout/v2/after-payment"]', text: 'After Payment') do
          end
        end
      end
    end

    it 'has expected page title' do
      expect(subject).to have_tag('title', text: 'Checkout v2 – After Payment')
    end
  end
end
