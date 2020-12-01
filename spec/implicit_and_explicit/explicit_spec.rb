RSpec.describe Array do
  subject(:sally) { [1, 2] }

  it 'has 2 elements' do
    puts "Subject.length = #{subject.length}" do
      expect(subject.length).to eq(2)
    end
  end

  it 'Remove an element' do
    subject.pop
    expect(subject.length).to eq(1)
  end

  it "creates a new object" do
    expect(sally).to eq([1, 2])
  end

end
