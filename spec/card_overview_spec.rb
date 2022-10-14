# frozen_string_literal: true

require 'sidebar'

describe SwedbankPay::Sidebar do
  include_context :shared, ['cards', 'index.html']

  describe @file do
    it 'has expected first card deck' do
      is_expected.to have_tag('article') do
        with_tag('h2#deck-1', :with => { :class => 'heading-line' }) do
          with_tag('a.header-anchor', :with => { :href => '#deck-1' })
        end
        with_tag('.row.card-list') do
          with_tag('.col-lg-6') do
            with_tag('a.dx-card.dx-card-module', :with => { :href => '/cards/deck1/card1' }) do
              with_tag('.dx-card-icon') do
                with_tag('i.material-icons-outlined', :text => /attach_money/)
              end
              with_tag('.dx-card-content') do
                with_tag('.h4', :text => 'Deck 1 Card 1')
                with_tag('span', :text => 'Deck One Card One')
              end
              with_tag('i.material-icons', :text => /arrow_forward/)
            end
          end
        end
      end
    end

    it 'has card with no icon' do
      is_expected.to have_tag('a.dx-card', :with => { :href => '/cards/deck1/card2' }) do
        with_tag('.dx-card-icon.d-none') do
          with_tag('i.material-icons', :text => /^\s*$/)
        end
        with_tag('.dx-card-content') do
          with_tag('.h4', :text => 'Deck 1 Card 2')
          with_tag('span', :text => 'Deck One Card Two')
        end
        with_tag('i.material-icons', :text => /arrow_forward/)
      end
    end

    it 'has expected second card deck' do
      is_expected.to have_tag('article') do
        with_tag('h2#deck-2', :with => { :class => 'heading-line' }) do
          with_tag('a.header-anchor', :with => { :href => '#deck-2' })
        end

        with_tag('.row.card-list') do
          with_tag('.col-lg-12') do
            with_tag('a.dx-card', :with => { :href => '/cards/deck2/card1' }) do
              with_tag('.dx-card-icon') do
                with_tag('i.material-icons', :text => /api/)
              end
              with_tag('.dx-card-content') do
                with_tag('.h4', :text => 'Deck 2 Card 1')
                with_tag('span', :text => 'Deck Two Card One')
              end
              with_tag('i.material-icons', :text => /arrow_forward/)
            end
          end
        end
      end
    end

    it 'has card with svg icon' do
      is_expected.to have_tag('.col-lg-12') do
        with_tag('a.dx-card', :with => { :href => '/cards/deck2/card2' }) do
          with_tag('.dx-card-icon') do
            with_tag('svg')
          end
          with_tag('.dx-card-content') do
            with_tag('.h4', :text => 'Deck 2 Card 2')
            with_tag('span', :text => 'Deck Two Card Two')
          end
          with_tag('i.material-icons', :text => /arrow_forward/)
        end
      end
    end

    it 'has horizontal card' do
      is_expected.to have_tag('.dx-card-horizontal') do
        with_tag('a.dx-card', :with => { :href => '/cards/deck2/card3' }) do
          with_tag('.dx-card-content') do
            with_tag('.h4', :text => 'Deck 2 Card 3')
            with_tag('span', :text => 'Deck Two Card Three')
          end
          with_tag('i.material-icons', :text => /arrow_forward/)
        end
      end
    end

    it 'has disabled default card' do
      is_expected.to have_tag('span.dx-card.dx-card-disabled') do
        with_tag('.dx-card-content') do
          with_tag('.h4', :text => 'Deck 3 Card 3')
          with_tag('span', :text => 'Deck Three Card Three (Disabled)')
        end
        without_tag('i.material-icons', :text => /arrow_forward/)
      end
    end

    it 'has disabled sdk card' do
      is_expected.to have_tag('span.dx-card-sdk.dx-card-disabled') do
        with_tag('.dx-card-content') do
          with_tag('.h4', :text => 'Deck 3 Card 1')
          with_tag('span', :text => 'Deck Three Card One (Disabled)')
        end
        without_tag('i.material-icons', :text => /arrow_forward/)
      end
    end

    it 'has disabled module card' do
      is_expected.to have_tag('span.dx-card-module.dx-card-disabled') do
        with_tag('.dx-card-content') do
          with_tag('.h4', :text => 'Deck 3 Card 2')
          with_tag('span', :text => 'Deck Three Card Two (Disabled)')
        end
        without_tag('i.material-icons', :text => /arrow_forward/)
      end
    end
  end
end
