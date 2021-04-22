# frozen_string_literal: true

describe 'Checkout Core Features' do
  include_context 'shared'
  core_features_path = File.join(@dest_dir, 'checkout', 'v2', 'features', 'core', 'index.html')

  describe core_features_path do
    subject { File.read(core_features_path) }

    it {
      expect(File).to exist(core_features_path)
    }

    it 'has expected cards' do
      is_expected.to have_tag('article') do
        with_tag('h2#core-features', :with => { :class => 'heading-line' }) do
          with_tag('a.header-anchor', :with => { :href => '#core-features' })
        end
        with_tag('.row.card-list') do
          with_tag('.col-lg-4') do
            with_tag('a.dx-card', :with => { :href => '/checkout/v2/features/core/3d-secure-2' }) do
              with_tag('.dx-card-icon') do
                with_tag('i.material-icons', :text => /3d_rotation/)
              end
              with_tag('.dx-card-content') do
                with_tag('.h4', :text => '3-D Secure 2')
                with_tag('span', :text => 'Authenticating the cardholder')
              end
              with_tag('i.material-icons', :text => /arrow_forward/)
            end
          end
        end
      end
    end
  end
end
