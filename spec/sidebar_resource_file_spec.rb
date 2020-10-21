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
