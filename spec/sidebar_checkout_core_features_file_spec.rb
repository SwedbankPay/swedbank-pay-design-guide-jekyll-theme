# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context :shared, ['checkout', 'v2', 'features', 'core', 'index.html']

  describe @file do
    it 'is missing header navigation' do
      is_expected.to have_tag('.sidebar') do
        with_tag('nav.sidebar-nav') do
          with_tag('ul.main-nav-ul') do
            with_tag('li.nav-group', with: { class: 'active' }) do
              with_tag('ul.nav-ul') do
                with_tag('li.nav-subgroup', with: { class: 'active' }) do
                  with_tag('ul.nav-ul') do
                    with_tag('li.nav-subgroup', with: { class: 'active' }) do
                      with_tag('ul.nav-ul') do
                        with_tag('li.nav-subgroup', with: { class: 'active' }) do
                          with_tag('ul.nav-ul') do
                            with_tag('li.nav-leaf', with: { class: 'nav-subgroup-leaf' }) do
                              with_tag('a[href="/checkout/v2/features/core/"]', text: 'Core Features')
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
        end
      end
    end
  end
end
