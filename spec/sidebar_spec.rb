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
  end
end
