# frozen_string_literal: true

require 'its'
require 'jekyll'
require 'sidebar'
require 'sidebar_page_collection'

sidebar = SwedbankPay::Sidebar

describe sidebar do
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

  describe '#pages' do
    subject { sidebar.pages }

    its(:count) { is_expected.to eq 28 }
    its(:length) { is_expected.to eq 1 }

    describe '[0]' do
      subject { sidebar.pages[0] }

      its(:path) { is_expected.to eq '/' }
      its(:children) { is_expected.to be_an_instance_of SwedbankPay::SidebarPageCollection }

      describe 'title' do
        subject { sidebar.pages[0].title.to_s }
        it { is_expected.to eq 'Home' }
      end

      describe 'children' do
        subject { sidebar.pages[0].children }

        its(:length) { is_expected.to eq 9 }

        describe '[0]' do
          describe 'title' do
            subject { sidebar.pages[0].children[0].title.to_s }
            it { is_expected.to eq 'Page 1' }
          end
        end

        describe '[5]' do
          subject { sidebar.pages[0].children[5] }

          describe 'title' do
            subject { sidebar.pages[0].children[5].title.to_s }
            it { is_expected.to eq 'Resources' }
          end

          describe 'children' do
            subject { sidebar.pages[0].children[5].children }

            its(:length) { is_expected.to eq 6 }

            describe '[0]' do
              subject { sidebar.pages[0].children[5].children[0] }

              describe 'title' do
                subject { sidebar.pages[0].children[5].children[0].title.to_s }
                it { is_expected.to eq 'Alpha' }
              end
            end

            describe '[1]' do
              describe 'title' do
                subject { sidebar.pages[0].children[5].children[1].title.to_s }
                it { is_expected.to eq 'Beta' }
              end
            end

            describe '[1]' do
              describe 'title' do
                subject { sidebar.pages[0].children[5].children[2].title.to_s }
                it { is_expected.to eq 'Gamma' }
              end
            end
          end
        end
      end
    end
  end

  index_path = File.join(dest_dir, 'index.html')

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
