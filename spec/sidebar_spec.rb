# frozen_string_literal: true

require 'jekyll'
require 'sidebar'

describe SwedbankPay::Sidebar do
  source_dir = File.join(__dir__, '..')
  dest_dir = File.join(source_dir, '_site')

  before(:all) do
    config = Jekyll.configuration(
      {
        'config' => File.join(source_dir, '_config.yml'),
        'source' => source_dir,
        'destination' => dest_dir
      }
    )
    Jekyll::Commands::Build.process(config)
  end

  index_path = File.join(dest_dir, 'index.html')

  describe index_path do
    subject { File.read(index_path) }

    it {
      expect(File).to exist(index_path)
    }

    it {
      is_expected.to include('<ul class="nav-ul"><li class="nav-leaf"><a href="/checkout/capture#step-5-capture-the-funds">Step 5: Capture the funds</a></li></ul>')
    }

    it {
      is_expected.to include('<i class="material-icons">arrow_right</i><a href="/checkout/payment-menu">Payment Menu</a>')
    }

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

  redirect_path = File.join(dest_dir, 'resources', 'redirect-from.html')

  describe redirect_path do
    subject { File.read(redirect_path) }

    it {
      expect(File).to exist(redirect_path)
    }

    it {
      is_expected.to_not include('<i class="material-icons">arrow_right</i><span>Home</span>')
    }
  end

  resource_path = File.join(dest_dir, 'resources', 'index.html')

  describe resource_path do
    subject { File.read(resource_path) }

    it {
      expect(File).to exist(resource_path)
    }

    it 'has expected nav structure' do
      is_expected.to have_tag('ul', class: 'nav-ul') do
        with_tag('li', class: 'nav-leaf nav-subgroup-leaf') do
          with_tag('a[href="/resources/"]', text: 'Resources')
        end
        with_tag('li', class: 'nav-subgroup-leaf') do
          with_tag('div', class: 'nav-subgroup-heading') do
            with_tag('i.material-icons', text: 'arrow_right')
            with_tag('a[href="/resources/release-notes"]', text: 'Release Notes')
          end
        end
        with_tag('li', class: 'nav-leaf nav-subgroup-leaf') do
          with_tag('a[href="/resources/sub-resources/"]', text: 'Sub-resources')
        end
      end
    end
  end
end
