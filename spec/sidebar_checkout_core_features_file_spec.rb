# frozen_string_literal: true

require "sidebar"

describe SwedbankPay::Sidebar do
  include_context "shared"
  checkout_core_features_path = File.join(@dest_dir, "checkout", "v2", "features", "core", "index.html")

  describe checkout_core_features_path do
    subject { File.read(checkout_core_features_path) }

    it {
      expect(File).to exist(checkout_core_features_path)
    }

    it "is missing header navigation" do
      is_expected.to have_tag("li.main-nav-li.active") do
        with_tag("li.main-nav-li.active") do
          with_tag('a[href="/checkout/"]')
          with_tag("nav.sidebar-secondary-nav") do
            with_tag("header.secondary-nav-header", Text: "Checkout")
            with_tag("ul.secondary-nav-ul") do
              with_tag("li.leaf", with: { class: "active" }) do
                with_tag('a[href="/checkout/v2/features/"]', text: "Features")
                with_tag("ul") do
                  with_tag("li.leaf", with: { class: "active" }) do
                    with_tag('a[href="/checkout/v2/features/core/"]', text: "Core Features")
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
