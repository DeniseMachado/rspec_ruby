class ProgrammingLanguage
  attr_reader :name

  def initialize(name = 'Ruby')
    @name = name
  end

  RSpec.describe ProgrammingLanguage do
    let(:language) { ProgrammingLanguage.new('Phyton') }

    it 'should store the name of the language' do
      expect(language.name).to eq('Phyton')
    end

    context 'with no arguments' do
      let(:language) { ProgrammingLanguage.new }

      it 'should store Ruby as default' do
        expect(language.name).to eq('Ruby')
      end
    end
  end
end
