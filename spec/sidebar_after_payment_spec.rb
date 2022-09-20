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
      is_expected.to have_tag('#dx-sidebar-main-nav-ul') do
        with_tag('li.group.active') do
          with_tag('a[href="/checkout/v2/after-payment"]', text: 'After Payment') do
            with_tag('i.material-icons-outlined')
          end
        end
        with_tag('li.main-nav-li.active') do
          with_tag('nav.sidebar-secondary-nav') do
            with_tag('ul.secondary-nav-ul') do
              with_tag('li.secondary-nav-li.leaf.active') do
                with_tag('a[href="/checkout/v2/"]', text: 'Checkout v2') do
                  with_tag('i.material-icons-outlined')
                end
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
