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

    its(:count) { is_expected.to eq 39 }
    its(:length) { is_expected.to eq 10 }

    describe '[0]' do
      let(:index) { |x| parse_index(x) }

      subject { sidebar.pages[index[0]] }

      its(:path) { is_expected.to eq '/' }
      its(:children) { is_expected.to be_an_instance_of SwedbankPay::SidebarPageCollection }
      its(:hidden?) { is_expected.to be false }

      describe 'title' do
        it { expect(subject.title.to_s).to eq 'Home' }
      end
    end

    describe '[2].title' do
      let(:index) { |x| parse_index(x) }
      it { expect(sidebar.pages[index[0]].title.to_s).to eq 'Page 1' }
    end

    describe '[4]' do
      let(:index) { |x| parse_index(x) }

      subject { sidebar.pages[index[0]] }

      its(:path) { is_expected.to eq '/checkout/' }
      its(:active?, '/checkout/') { is_expected.to be true }
      its(:active?, '/checkout/after-payment') { is_expected.to be true }
      its(:active?, '/checkout/features/payment-orders') { is_expected.to be true }
      its(:active?, '/checkout/features/payment-orders', is_leaf: true) { is_expected.to be false }
      its(:hidden?) { is_expected.to be false }

      describe 'children[3]' do
        subject { sidebar.pages[index[0]].children[index[1]] }

        its(:path) { is_expected.to eq '/checkout/after-payment' }
        its(:active?, '/checkout/after-payment') { is_expected.to be true }
      end

      describe 'children[4]' do
        subject { sidebar.pages[index[0]].children[index[1]] }

        its(:path) { is_expected.to eq '/checkout/features/' }
        its(:active?, '/checkout/features/payment-orders') { is_expected.to be true }
        its(:active?, '/checkout/features/payment-orders', is_leaf: true) { is_expected.to be false }

        describe 'children[0]' do
          subject { sidebar.pages[index[0]].children[index[1]].children[index[2]] }

          its(:path) { is_expected.to eq '/checkout/features/payment-orders' }
          its(:active?, '/checkout/features/payment-orders') { is_expected.to be true }
        end
      end
    end

    describe '[6]' do
      let(:index) { |x| parse_index(x) }
      subject { sidebar.pages[index[0]] }

      describe 'title' do
        it { expect(subject.title.to_s).to eq 'Payments' }
      end

      describe 'children' do
        subject { sidebar.pages[index[0]].children }

        its(:length) { is_expected.to eq 3 }

        describe '[2]' do
          subject { sidebar.pages[index[0]].children[index[1]] }

          its(:hidden?) { is_expected.to be true }

          describe 'title' do
            it { expect(subject.title.to_s).to eq 'Secret payments' }
          end

          describe 'children' do
            subject { sidebar.pages[index[0]].children[index[1]].children }

            its(:length) { is_expected.to eq 1 }

            describe '[0]' do
              subject { sidebar.pages[index[0]].children[index[1]].children[index[2]] }

              its(:hidden?) { is_expected.to be true }

              describe 'title' do
                it { expect(subject.title.to_s).to eq 'Secrets in payments' }
              end
            end
          end
        end
      end
    end

    describe '[7]' do
      let(:index) { |x| parse_index(x) }
      subject { sidebar.pages[index[0]] }

      describe 'title' do
        it { expect(subject.title.to_s).to eq 'Resources' }
      end

      describe 'children' do
        subject { sidebar.pages[index[0]].children }

        its(:length) { is_expected.to eq 5 }

        describe '[0].title' do
          it { expect(subject[0].title.to_s).to eq 'Alpha' }
        end

        describe '[1].title' do
          it { expect(subject[1].title.to_s).to eq 'Beta' }
        end

        describe '[2].title' do
          it { expect(subject[2].title.to_s).to eq 'Gamma' }
        end
      end
    end
  end
end
