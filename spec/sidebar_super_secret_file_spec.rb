# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context 'shared'
  # TODO: Hidden pages should be hidden from non-hidden pages, but not from other hidden pages within the same or lower hierarchy.
  super_secret_path = File.join(@dest_dir, 'payments', 'secrets' , 'super-secret.html')

  describe super_secret_path do
    subject { File.read(super_secret_path) }

    it {
      expect(File).to exist(super_secret_path)
    }

    # <li class="nav-subgroup active">
    #   <div class="nav-subgroup-heading">
    #     <i class="material-icons">arrow_right</i>
    #     <a href="/payments/secrets/">Secret payments</a>
    #   </div>
    #   <ul class="nav-ul">
    #     <li class="nav-subgroup">
    #       <div class="nav-subgroup-heading">
    #         <i class="material-icons">arrow_right</i>
    #         <a href="/payments/secrets/">Secret payments</a>
    #       </div>
    #       <ul class="nav-ul">
    #         <li class="nav-leaf"><a href="/payments/secrets/#how-we-do-secret-payments">How we do secret payments</a></li>
    #       </ul>
    #     </li>
    #     <li class="nav-subgroup active">
    #       <div class="nav-subgroup-heading">
    #         <i class="material-icons">arrow_right</i>
    #         <a href="/payments/secrets/super-secret">Secrets in payments</a>
    #       </div>
    #       <ul class="nav-ul">
    #         <li class="nav-leaf"><a href="/payments/secrets/super-secret#dont-render-this">Don’t render this</a></li>
    #       </ul>
    #     </li>
    #   </ul>
    # </li>

    # The navigation for a section that has `hide_from_sidebar: true` should not
    # be hidden from itself.
    it 'has expected nav structure' do
      is_expected.to have_tag('ul', class: 'nav-ul') do
        with_tag('li', class: 'nav-subgroup active') do
          with_tag('div', class: 'nav-subgroup-heading') do
            with_tag('i.material-icons', text: 'arrow_right')
            with_tag('a[href="/payments/secrets/"]', text: 'Secret payments')
          end
        end
      end
    end
  end
end
