# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  index_path = File.expand_path(File.join(@dest_dir, 'index.html'))

  describe index_path do
    subject { File.read(index_path) }

    it {
      expect(File).to exist(index_path)
    }

    it 'has nav leaf' do
      is_expected.to have_tag('ul#dx-sidebar-main-nav-ul') do
        with_tag('li.main-nav-li') do
          with_tag('nav.sidebar-secondary-nav') do
            with_tag('ul.secondary-nav-ul') do
              with_tag('li.secondary-nav-li.leaf') do
                with_tag('li.leaf') do
                  with_tag('a[href="/checkout/v2/"]', text: 'Checkout v2')
                end
              end
            end
          end
        end
      end
    end

    it 'has active home item' do
      is_expected.to have_tag('ul#dx-sidebar-main-nav-ul.main-nav-ul') do
        with_tag('li.main-nav-li.active') do
          with_tag('a[href="/"]', text: 'homeHome') do
            with_tag('i.material-icons-outlined', text: 'home')
          end
          with_tag('nav.sidebar-secondary-nav') do
            with_tag('header.secondary-nav-header', text: 'Home')
          end
        end
      end
    end

    it 'has checkin items' do
      is_expected.to have_tag('ul#dx-sidebar-main-nav-ul') do
        with_tag('li.main-nav-li') do
          with_tag('nav.sidebar-secondary-nav') do
            with_tag('ul.secondary-nav-ul') do
              with_tag('li.secondary-nav-li.leaf') do
                with_tag('li.group') do
                  with_tag('li.nav-leaf') do
                    with_tag('a[href="/checkout/v2/checkin#step-1-initiate-session-for-consumer-identification"]', text: 'Step 1: Initiate session for consumer identification')
                  end
                  with_tag('li.nav-leaf') do
                    with_tag('a[href="/checkout/v2/checkin#step-2-display-swedbank-pay-checkin-module"]', text: 'Step 2: Display Swedbank Pay Checkin module')
                  end
                end
              end
            end
          end
        end
      end
    end

    # Hidden pages shouldn't be visible for non-hidden pages
    it 'has no navigation for hidden pages' do
      is_expected.not_to have_tag('a[href="/payments/secrets/"]')
      is_expected.not_to have_tag('a[href="/payments/secrets/super-secret"]')
    end
  end
end
