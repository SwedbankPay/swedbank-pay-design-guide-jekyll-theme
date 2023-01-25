# frozen_string_literal: true

require "sidebar"

describe SwedbankPay::Sidebar do
  include_context "shared"
  checkin_path = File.join(@dest_dir, "checkout", "v2", "checkin.html")

  describe checkin_path do
    subject { File.read(checkin_path) }

    it {
      expect(File).to exist(checkin_path)
    }

    it "has expected nav structure" do
      is_expected.to have_tag("li.main-nav-li.active") do
        with_tag("li.group.active") do
          with_tag('a[href="/checkout/v2/checkin"]', text: "Checkout – Checkin")
          with_tag("ul") do
            with_tag("li.nav-leaf") do
              with_tag('a[href="/checkout/v2/checkin#step-1-initiate-session-for-consumer-identification"]',
                       text: "Step 1: Initiate session for consumer identification")
              with_tag("li.nav-leaf") do
              end
            end
          end
        end
      end
    end

    it "has expected title header" do
      is_expected.to have_tag("div.title-header") do
        with_tag("div.title-header-container") do
          with_tag("h4", text: "Checkout v2")
          with_tag("h1", text: "Checkin")
          with_tag("div.title-header-estimated-read", text: /6 min read/)
        end
      end
    end

    it "has expected page title" do
      is_expected.to have_tag("title", text: "Checkout v2 – Checkin")
    end
  end
end
