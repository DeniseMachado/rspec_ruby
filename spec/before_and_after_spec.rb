
RSpec.describe 'before and after hooks' do

  #Before and after context corre apenas uma vez, antes de todos os exemplos e no final de todos
  before(:context) do
    puts 'Before context'
  end

  after(:context) do
    puts 'After context'
  end

  #Before and after example corre sempre antes e depois de cada exemplo
  before(:example) do
    puts 'Before example'
  end

  after(:example) do
    puts 'After example'
  end

  it 'is just a random example' do
    expect(5 * 4).to eq(20)
  end

  it 'is just another random example' do
    expect(3 - 1).to eq(2)
  end
end
