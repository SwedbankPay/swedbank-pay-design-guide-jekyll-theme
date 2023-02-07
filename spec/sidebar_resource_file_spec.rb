# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  resource_path = File.join(@dest_dir, 'resources', 'index.html')

  describe resource_path do
    subject { File.read(resource_path) }

    it {
      expect(File).to exist(resource_path)
    }

    it 'has expected nav structure' do
      expect(subject).to have_tag('ul#dx-sidebar-main-nav-ul') do
        with_tag('li.main-nav-li.active') do
          # TODO: Navigate to http://localhost:4000/resources/ and fix the link
          # that is currently empty.
          with_tag('a[href="/resources/"]', text: /Resources/)
        end
        with_tag('nav.sidebar-secondary-nav') do
          with_tag('li.secondary-nav-li') do
            with_tag('a[href="/resources/release-notes"]', text: 'Release Notes')
          end
        end
        with_tag('li.secondary-nav-li') do
          with_tag('a[href="/resources/sub-resources/"]', text: 'Sub-resources')
        end
      end
    end
  end
end
