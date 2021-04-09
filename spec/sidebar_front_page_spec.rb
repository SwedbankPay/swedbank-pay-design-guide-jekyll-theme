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
                with_tag('a[href="/checkout/v2/features/core/payment-order"]', text: 'Payment Order')
              end
              with_tag('ul.nav-ul') do
                with_tag('li.nav-leaf') do
                  with_tag('a[href="/checkout/v2/features/core/payment-order"]', text: 'Payment Order')
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
          with_tag('div.release-notes-date') do
            with_tag('a[href="/resources/release-notes#28-may-2020"]', text: '28 May 2020')
          end
          with_tag('div') do
            with_tag('p.h4') do
              with_tag('a[href="/resources/release-notes#version-1110"]', text: 'Version 1.11.0')
            end
            with_tag('ul') do
              with_tag('li', text: 'Added a new Trustly Payments section.')
            end
          end
        end
      end
    end
  end
end
