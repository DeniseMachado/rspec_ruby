class School
  attr_reader :name, :students

  def initialize(name)
    @name = name
    @students = []
  end
end

RSpec.describe School do
  before do
    puts 'I will run before each example'
  end

  it 'has a name' do
    school = School.new('Nova de Aveiro')

    expect(school.name).to eq('Nova de Aveiro')
  end

  it 'should start off with no students' do
    school = School.new('Nova de Aveiro')

    expect(school.students).to eq([])
  end
end
