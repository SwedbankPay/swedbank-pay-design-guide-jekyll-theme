# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  after_payment_path = File.join(@dest_dir, 'checkout', 'v2', 'after-payment.html')

  describe after_payment_path do
    subject { File.read(after_payment_path) }

    it {
      expect(File).to exist(after_payment_path)
    }

    it 'has active item' do
      is_expected.to have_tag('ul.main-nav-ul') do
        with_tag('li.nav-group.active') do
          with_tag('ul.nav-ul') do
            with_tag('li.nav-subgroup.active') do
              with_tag('div.nav-subgroup-heading') do
                with_tag('i.material-icons', text: 'arrow_right')
                with_tag('a[href="/checkout/v2/after-payment"]', text: 'After Payment')
              end
            end
          end
        end
      end
    end

    it 'has expected page title' do
      is_expected.to have_tag('title', text: 'Checkout v2 – After Payment')
    end
  end
end
