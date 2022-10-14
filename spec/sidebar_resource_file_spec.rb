# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context :shared, ['resources', 'index.html']

  describe @file do
    it 'has expected nav structure' do
      is_expected.to have_tag('ul.nav-ul') do
        with_tag('li.nav-leaf') do
          with_tag('a[href="/resources/"]', text: 'Resources')
        end
        with_tag('li.nav-subgroup') do
          with_tag('div.nav-subgroup-heading') do
            with_tag('i.material-icons', text: 'arrow_right')
            with_tag('a[href="/resources/release-notes"]', text: 'Release Notes')
          end
        end
        with_tag('li.nav-leaf.nav-subgroup-leaf') do
          with_tag('a[href="/resources/sub-resources/"]', text: 'Sub-resources')
        end
      end
    end
  end
end
