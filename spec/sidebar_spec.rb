# frozen_string_literal: true

require 'its'
require 'jekyll'
require 'sidebar'
require 'sidebar_page_collection'

sidebar = SwedbankPay::Sidebar

describe sidebar do
  include_context 'shared'

  describe '#pages' do
    subject { sidebar.pages }

    its(:count) { is_expected.to eq 28 }
    its(:length) { is_expected.to eq 10 }

    describe '[0]' do
      subject { sidebar.pages[0] }

      its(:path) { is_expected.to eq '/' }
      its(:children) { is_expected.to be_an_instance_of SwedbankPay::SidebarPageCollection }

      describe 'title' do
        subject { sidebar.pages[0].title.to_s }
        it { is_expected.to eq 'Home' }
      end
    end

    describe '[1]' do
      describe 'title' do
        subject { sidebar.pages[1].title.to_s }
        it { is_expected.to eq 'Page 1' }
      end
    end

    describe '[5]' do
      subject { sidebar.pages[6] }

      describe 'title' do
        subject { sidebar.pages[6].title.to_s }
        it { is_expected.to eq 'Resources' }
      end

      describe 'children' do
        subject { sidebar.pages[6].children }

        its(:length) { is_expected.to eq 6 }

        describe '[0]' do
          subject { sidebar.pages[6].children[0] }

          describe 'title' do
            subject { sidebar.pages[6].children[0].title.to_s }
            it { is_expected.to eq 'Alpha' }
          end
        end

        describe '[1]' do
          describe 'title' do
            subject { sidebar.pages[6].children[1].title.to_s }
            it { is_expected.to eq 'Beta' }
          end
        end

        describe '[1]' do
          describe 'title' do
            subject { sidebar.pages[6].children[2].title.to_s }
            it { is_expected.to eq 'Gamma' }
          end
        end
      end
    end
  end
end
