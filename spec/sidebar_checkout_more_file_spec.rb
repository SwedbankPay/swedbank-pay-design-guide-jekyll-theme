# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  checkout_more_path = File.join(@dest_dir, 'checkout-more', 'after-payment.html')

  describe checkout_more_path do
    subject { File.read(checkout_more_path) }

    it {
      expect(File).to exist(checkout_more_path)
    }

    it 'has expected nav structure' do
      is_expected.to have_tag('li.main-nav-li.active') do
        with_tag('a[href="/checkout-more/"]')
      end
          with_tag('nav.sidebar-secondary-nav') do
              with_tag('a[href="/checkout-more/after-payment#after-paaaayment"]',
                text: 'After paaaayment')
          end
    end

    it 'has expected title header' do
      is_expected.to have_tag('div.title-header') do
        with_tag('div.title-header-container') do
          with_tag('h4', text: 'Checkout More')
          with_tag('h1', text: 'After payment is completed')
        end
      end
    end
  end
end
