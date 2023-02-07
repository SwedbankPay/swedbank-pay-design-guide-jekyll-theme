# frozen_string_literal: false

describe 'Checkout Core Features' do
  include_context 'shared'
  core_features_path = File.join(@dest_dir, 'checkout', 'v2', 'features', 'core', 'index.html')

  describe core_features_path do
    subject { File.read(core_features_path) }

    it {
      expect(File).to exist(core_features_path)
    }

    it 'has expected cards' do
      expect(subject).to have_tag('article') do
        with_tag('h2#core-features', with: { class: 'heading-line' }) do
          with_tag('a.header-anchor', with: { href: '#core-features' })
        end
        with_tag('.row.card-list') do
          with_card('3d-secure-2', '3-D Secure 2', 'Authenticating the cardholder', '3d_rotation', false)
          with_card('payment-order-abort', 'Abort', 'Aborting a created payment', 'pan_tool')
          with_card('cancel', 'Cancel', 'Cancelling the authorization and releasing the funds', 'pan_tool')
          with_card('payment-order-capture', 'Capture', 'Capturing the authorized funds', 'compare_arrow')
          with_card('payment-order', 'Payment Order', 'Creating the payment order', 'credit_card')
          with_card('reversal', 'Reversal', 'How to reverse a payment', 'keyboard_return')
          with_card('settlement-reconciliation', 'Settlement & Reconciliation', 'Balancing the books', 'description')
        end
      end
    end
  end

  def with_card(href, title, body, icon, icon_outlined = true)
    href = "/checkout/v2/features/core/#{href}"
    icon_type = 'material-icons'
    icon_type << '-outlined' if icon_outlined

    with_tag('.col-lg-4') do
      with_tag('a.dx-card', with: { href: href }) do
        with_tag('.dx-card-icon') do
          with_tag('i', text: /#{icon}/, with: { class: icon_type })
        end
        with_tag('.dx-card-content') do
          with_tag('.h4', text: title)
          with_tag('span', text: body)
        end
        with_tag('i.material-icons', text: /arrow_forward/)
      end
    end
  end
end
