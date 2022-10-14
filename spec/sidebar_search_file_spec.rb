# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context :shared, 'search.html'

  describe @file do
    it 'does not have search item' do
      is_expected.not_to have_tag('.main-nav-ul span', text: 'Search')
      is_expected.not_to have_tag('.main-nav-ul a[href="/search"]')
    end
  end
end
