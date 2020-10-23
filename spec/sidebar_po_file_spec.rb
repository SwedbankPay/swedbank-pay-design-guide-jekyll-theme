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
      is_expected.to have_tag('ul', class: 'nav-ul') do
        with_tag('li.nav-subgroup.active') do
          with_tag('ul', class: 'nav-ul') do
            with_tag('li.nav-subgroup.active') do
              with_tag('div', class: 'nav-subgroup-heading') do
                with_tag('i.material-icons', text: 'arrow_right')
                with_tag('a[href="/checkout/features/payment-orders"]', text: 'Payment Orders')
              end
              with_tag('ul', class: 'nav-ul') do
                with_tag('li', class: 'nav-leaf') do
                  with_tag('a[href="/checkout/features/payment-orders#payment-orders"]', text: 'Payment Orders')
                end
              end
            end
          end
        end
      end
    end
  end
end
