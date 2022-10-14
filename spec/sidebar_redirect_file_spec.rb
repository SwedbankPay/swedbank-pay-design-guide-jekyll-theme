# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  redirect_path = File.expand_path(File.join(@dest_dir, 'resources', 'redirect-from.html'))

  describe redirect_path do
    subject { File.read(redirect_path) }

    it {
      expect(File).to exist(redirect_path)
    }

    it {
      is_expected.to_not include('<i class="material-icons">arrow_right</i><span>Home</span>')
    }
  end
end
