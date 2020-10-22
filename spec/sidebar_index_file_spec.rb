# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  index_path = File.join(@dest_dir, 'index.html')

  describe index_path do
    subject { File.read(index_path) }

    it {
      expect(File).to exist(index_path)
    }

    it 'has nav leaf' do
      is_expected.to have_tag('ul', class: 'nav-ul') do
        with_tag('li', class: 'nav-leaf') do
          with_tag('a[href="/checkout/capture#step-5-capture-the-funds"]', text: 'Step 5: Capture the funds')
        end
      end
    end

    it 'has subgroup' do
      is_expected.to have_tag('li', class: 'nav-subgroup') do
        with_tag('div', class: 'nav-subgroup-heading') do
          with_tag('i.material-icons', text: 'arrow_right')
          with_tag('a[href="/checkout/payment-menu"]', text: 'Payment Menu')
        end
      end
    end

    it 'has active home item' do
      is_expected.to have_tag('ul#dx-sidebar-main-nav-ul', class: 'main-nav-ul') do
        with_tag('li', class: 'nav-group active') do
          with_tag('div', class: 'nav-group-heading') do
            with_tag('i.material-icons', text: 'arrow_right')
            with_tag('span', text: 'Home')
          end
        end
      end
    end

    it 'has checkin items' do
      is_expected.to have_tag('li', class: 'nav-subgroup') do
        with_tag('div', class: 'nav-subgroup-heading') do
          with_tag('i.material-icons', text: 'arrow_right')
          with_tag('a[href="/checkout/checkin"]', text: 'Checkin')
        end
        with_tag('ul', class: 'nav-ul') do
          with_tag('li', class: 'nav-leaf') do
            with_tag('a[href="/checkout/checkin#step-1-initiate-session-for-consumer-identification"]', text: 'Step 1: Initiate session for consumer identification')
          end
          with_tag('li', class: 'nav-leaf') do
            with_tag('a[href="/checkout/checkin#step-2-display-swedbank-pay-checkin-module"]', text: 'Step 2: Display Swedbank Pay Checkin module')
          end
        end
      end
    end

    it 'has introduction item' do
      is_expected.to have_tag('ul', class: 'nav-ul') do
        with_tag('li', class: 'nav-subgroup') do
          with_tag('div', class: 'nav-subgroup-heading') do
            with_tag('i.material-icons', text: 'arrow_right')
            with_tag('a[href="/checkout/"]', text: 'Introduction')
          end
        end
      end
    end
  end
end
