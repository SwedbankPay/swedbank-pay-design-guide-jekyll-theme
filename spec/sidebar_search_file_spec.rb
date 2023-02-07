# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  search_path = File.join(@dest_dir, 'search.html')

  describe search_path do
    subject { File.read(search_path) }

    it {
      expect(File).to exist(search_path)
    }

    it 'does not have search item' do
      expect(subject).not_to have_tag('.main-nav-ul span', text: 'Search')
      expect(subject).not_to have_tag('.main-nav-ul a[href="/search"]')
    end
  end
end
