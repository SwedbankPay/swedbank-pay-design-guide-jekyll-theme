# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  front_page_path = File.join(@dest_dir, 'page1.html')

  describe front_page_path do
    subject { File.read(front_page_path) }

    it {
      expect(File).to exist(front_page_path)
    }

    it 'has expected nav structure' do
      is_expected.to have_tag('ul.nav-ul') do
        with_tag('li.nav-subgroup') do
          with_tag('ul.nav-ul') do
            with_tag('li.nav-subgroup') do
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

    it 'has release notes' do
      is_expected.to have_tag('div.front-page-release-notes') do
        with_tag('div.release-notes-container') do
          with_tag('div.release-notes-date', text: /28 May 2020/)
          with_tag('div') do
            with_tag('p.h4', text: 'Version 1.11.0')
            with_tag('ul') do
              with_tag('li', text: 'Added a new Trustly Payments section.')
            end
          end
        end
      end
    end
  end
end
