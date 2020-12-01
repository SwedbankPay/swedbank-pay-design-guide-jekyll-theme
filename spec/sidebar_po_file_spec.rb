# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  po_path = File.join(@dest_dir, 'checkout', 'features', 'payment-orders.html')

  describe po_path do
    subject { File.read(po_path) }

    it {
      expect(File).to exist(po_path)
    }

    it 'has expected nav structure' do
      is_expected.to have_tag('ul.nav-ul') do
        with_tag('li.nav-subgroup.active') do
          with_tag('ul.nav-ul') do
            with_tag('li.nav-subgroup.active') do
              with_tag('div.nav-subgroup-heading') do
                with_tag('i.material-icons', text: 'arrow_right')
                with_tag('a[href="/checkout/features/payment-orders"]', text: 'Payment Orders')
              end
              with_tag('ul.nav-ul') do
                with_tag('li.nav-leaf') do
                  with_tag('a[href="/checkout/features/payment-orders#payment-orders"]', text: 'Payment Orders')
                end
              end
            end
          end
        end
      end
    end

    it 'has expected titles' do
      is_expected.to have_tag('div.title-header') do
        with_tag('div.title-header-container') do
          with_tag('h4', text: 'Checkout Features')
          with_tag('h1', text: 'Payment Orders')
        end
      end
    end
  end
end
