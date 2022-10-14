# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context :shared, 'index.html'

  describe @file do
    it 'has nav leaf' do
      is_expected.to have_tag('ul.nav-ul') do
        with_tag('li.nav-leaf') do
          with_tag('a[href="/checkout/v2/capture"]', text: 'Capture')
        end
      end
    end

    it 'has subgroup' do
      is_expected.to have_tag('li.nav-subgroup') do
        with_tag('div.nav-subgroup-heading') do
          with_tag('i.material-icons', text: 'arrow_right')
          with_tag('a[href="/checkout/v2/payment-menu"]', text: 'Payment Menu')
        end
      end
    end

    it 'has active home item' do
      is_expected.to have_tag('ul#dx-sidebar-main-nav-ul.main-nav-ul') do
        with_tag('li.nav-group.active') do
          with_tag('div.nav-group-heading') do
            with_tag('i.material-icons', text: 'arrow_right')
            with_tag('span', text: 'Home')
          end
        end
      end
    end

    it 'has checkin items' do
      is_expected.to have_tag('li.nav-subgroup') do
        with_tag('div.nav-subgroup-heading') do
          with_tag('i.material-icons', text: 'arrow_right')
          with_tag('a[href="/checkout/v2/checkin"]', text: 'Checkin')
        end
        with_tag('ul.nav-ul') do
          with_tag('li.nav-leaf') do
            with_tag('a[href="/checkout/v2/checkin#step-1-initiate-session-for-consumer-identification"]', text: 'Step 1: Initiate session for consumer identification')
          end
          with_tag('li.nav-leaf') do
            with_tag('a[href="/checkout/v2/checkin#step-2-display-swedbank-pay-checkin-module"]', text: 'Step 2: Display Swedbank Pay Checkin module')
          end
        end
      end
    end

    it 'has introduction item' do
      is_expected.to have_tag('ul.nav-ul') do
        with_tag('li.nav-subgroup') do
          with_tag('div.nav-subgroup-heading') do
            with_tag('i.material-icons', text: 'arrow_right')
            with_tag('a[href="/checkout/v2/"]', text: 'Checkout v2')
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
