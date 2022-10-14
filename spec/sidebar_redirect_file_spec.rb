# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context :shared, ['resources', 'redirect-from.html']

  describe @file do
    it { is_expected.to_not include('<i class="material-icons">arrow_right</i><span>Home</span>') }
  end
end
