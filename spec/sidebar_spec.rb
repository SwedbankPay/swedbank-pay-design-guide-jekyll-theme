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

    its(:count) { is_expected.to eq 211 }
    its(:length) { is_expected.to eq 11 }

    describe '[0]' do
      let(:index) { |x| parse_index(x) }

      subject { sidebar.pages[index[0]] }

      its(:path) { is_expected.to eq '/' }
      its(:children) { is_expected.to be_an_instance_of SwedbankPay::SidebarPageCollection }
      its(:hidden?) { is_expected.to be false }
      its(:title) { is_expected.to be_string 'Home' }
    end

    describe '[1].title' do
      let(:index) { |x| parse_index(x) }
      it { expect(sidebar.pages[index[0]].title).to be_string 'Page 1' }
    end

    describe '[4]' do
      let(:index) { |x| parse_index(x) }

      subject { sidebar.pages[index[0]] }

      its(:path) { is_expected.to eq '/checkout/' }
      its(:active?, '/checkout/') { is_expected.to be true }
      its(:hidden?) { is_expected.to be false }

      describe 'children[0]' do
        subject { sidebar.pages[index[0]].children[index[1]] }

        its(:title) { is_expected.to be_string 'Checkout v2' }
        its(:path) { is_expected.to eq '/checkout/v2/' }
        its(:active?, '/checkout/v2/after-payment') { is_expected.to be true }
        its(:active?, '/checkout/v2/features/core/payment-order') { is_expected.to be true }
        its(:active?, '/checkout/v2/features/core/payment-order', is_leaf: true) { is_expected.to be false }

        describe 'children[3]' do
          subject { sidebar.pages[index[0]].children[index[1]].children[index[2]] }

          its(:path) { is_expected.to eq '/checkout/v2/after-payment' }
          its(:active?, '/checkout/v2/after-payment') { is_expected.to be true }
        end

        describe 'children[4]' do
          subject { sidebar.pages[index[0]].children[index[1]].children[index[2]] }

          its(:path) { is_expected.to eq '/checkout/v2/features/' }
          its(:active?, '/checkout/v2/features/core/payment-order') { is_expected.to be true }
          its(:active?, '/checkout/v2/features/core/payment-order', is_leaf: true) { is_expected.to be false }

          describe 'children[0]' do
            subject { sidebar.pages[index[0]].children[index[1]].children[index[2]].children[index[3]] }

            its(:path) { is_expected.to eq '/checkout/v2/features/core/' }
            its(:active?, '/checkout/v2/features/core/') { is_expected.to be true }

            describe 'children[4]' do
              subject { sidebar.pages[index[0]].children[index[1]].children[index[2]].children[index[3]].children[index[4]] }

              its(:path) { is_expected.to eq '/checkout/v2/features/core/payment-order' }
              its(:active?, '/checkout/v2/features/core/payment-order') { is_expected.to be true }
            end
            end
        end
      end
    end

    describe '[6]' do
      let(:index) { |x| parse_index(x) }
      subject { sidebar.pages[index[0]] }

      its(:title) { is_expected.to be_string 'Payments' }

      describe 'children' do
        subject { sidebar.pages[index[0]].children }

        its(:length) { is_expected.to eq 3 }

        describe '[2]' do
          subject { sidebar.pages[index[0]].children[index[1]] }

          its(:hidden?) { is_expected.to be true }
          its(:title) { is_expected.to be_string 'Secret payments' }

          describe 'children' do
            subject { sidebar.pages[index[0]].children[index[1]].children }

            its(:length) { is_expected.to eq 1 }

            describe '[0]' do
              subject { sidebar.pages[index[0]].children[index[1]].children[index[2]] }

              its(:hidden?) { is_expected.to be true }
              its(:title) { is_expected.to be_string 'Secrets in payments' }
            end
          end
        end
      end
    end

    describe '[8]' do
      let(:index) { |x| parse_index(x) }
      subject { sidebar.pages[index[0]] }

      its(:title) { is_expected.to be_string 'Resources' }

      describe 'children' do
        subject { sidebar.pages[index[0]].children }

        its(:length) { is_expected.to eq 5 }

        describe '[0].title' do
          it { expect(subject[0].title).to be_string 'Alpha' }
        end

        describe '[1].title' do
          it { expect(subject[1].title).to be_string 'Beta' }
        end

        describe '[2].title' do
          it { expect(subject[2].title).to be_string 'Gamma' }
        end
      end
    end
  end
end
