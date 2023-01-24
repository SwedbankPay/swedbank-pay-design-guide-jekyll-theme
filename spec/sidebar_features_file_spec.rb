# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  features_path = File.join(@dest_dir, 'checkout', 'v2', 'features', 'index.html')

  describe features_path do
    subject { File.read(features_path) }

    it {
      expect(File).to exist(features_path)
    }

    it 'has expected nav structure' do
      is_expected.to have_tag('ul#dx-sidebar-main-nav-ul') do
        with_tag('li.main-nav-li.active') do
          with_tag('ul.nav-ul') do
            with_tag('li.nav-leaf') do
              with_tag('li.nav-leaf') do
                  with_tag('a[href="/checkout/v2/#prerequisites"]', text: 'Prerequisites')
                end
            end
          end
        end
      end
    end

    it 'has expected title header' do
      is_expected.to have_tag('div.title-header') do
        with_tag('div.title-header-container') do
          with_tag('h4', text: 'Checkout v2')
          with_tag('h1', text: 'Features')
        end
      end
    end

    it 'has expected page title' do
      is_expected.to have_tag('title', text: 'Checkout v2 – Features')
    end
  end
end
