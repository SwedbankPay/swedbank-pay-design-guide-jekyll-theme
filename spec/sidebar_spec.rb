# frozen_string_literal: true

require 'sidebar'

describe Jekyll::Sidebar do
  describe 'render' do
    source_dir = File.join(__dir__, '..')
    dest_dir = File.join(source_dir, '_site')

    before(:all) do
      config = Jekyll.configuration(
        {
          'config' => File.join(source_dir, '_config.yml'),
          'source' => source_dir,
          'destination' => dest_dir
        }
      )
      Jekyll::Commands::Build.process(config)
    end

    index_path = File.join(dest_dir, 'index.html')

    subject { File.read(index_path) }

    it {
      expect(File).to exist(index_path)
    }

    it {
      is_expected.to include('<i class="material-icons">arrow_right</i><span>Home</span>')
    }

    it {
      is_expected.to include('<ul class="nav-ul"><li class="nav-leaf"><a href="/checkout/capture#step-5-capture-the-funds">Step 5: Capture the funds</a></li></ul>')
    }

    it {
      is_expected.to include('<i class="material-icons">arrow_right</i><a href="/checkout/payment-menu">Payment Menu</a>')
    }

    it 'has expected nav structure' do
      is_expected.to have_tag('ul', class: 'nav-ul') do
        with_tag('li', class: 'nav-subgroup') do
          with_tag('div', class: 'nav-subgroup-heading') do
            with_tag('i.material-icons', text: 'arrow_right')
            with_tag('a[href="/checkout/"]', text: 'Introduction')
          end
        end
      end
    end
  end
end
