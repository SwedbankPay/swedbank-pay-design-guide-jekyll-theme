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

    # The navigation for a section that has `hide_from_sidebar: true` should not
    # be hidden from itself.
    it 'has expected nav structure' do
      is_expected.to have_tag('ul.nav-ul') do
        with_tag('li.nav-subgroup.active') do
          with_tag('div.nav-subgroup-heading') do
            with_tag('i.material-icons', text: 'arrow_right')
            with_tag('a[href="/payments/secrets/"]', text: 'Secret payments')
          end

          with_tag('ul.nav-ul') do
            with_tag('li.nav-subgroup') do
              with_tag('div.nav-subgroup-heading') do
                with_tag('i.material-icons', text: 'arrow_right')
                with_tag('a[href="/payments/secrets/"]', text: 'Secret payments')
              end
              with_tag('ul.nav-ul') do
                with_tag('li.nav-leaf') do
                  with_tag('a[href="/payments/secrets/#how-we-do-secret-payments"]', text: 'How we do secret payments')
                end
              end
            end

            with_tag('li.nav-subgroup.active') do
              with_tag('div.nav-subgroup-heading') do
                with_tag('i.material-icons', text: 'arrow_right')
                with_tag('a[href="/payments/secrets/super-secret"]', text: 'Secrets in payments')
              end
              with_tag('ul.nav-ul') do
                with_tag('li.nav-leaf') do
                  with_tag('a[href="/payments/secrets/super-secret#dont-render-this"]', text: 'Don’t render this')
                end
              end
            end
          end
        end
      end
    end
  end
end
