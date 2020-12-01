RSpec.describe Array do
  it 'should be empty' do
    expect(subject).to be_empty
  end

  it 'should have length equal to zero' do
    puts "subject -> #{subject}, is an empty array, and is class is -> #{subject.class}"
    expect(subject.length).to eq(0)
    subject.push(32)
    puts "subject -> #{subject}, is not an empty array"
    expect(subject.length).to eq(1)
  end
end

# What does the subject helper method return?
# An instance of the class under test.

# Why is better to pass a class argument to the describe method instead of a string with the class name?
# It is better to pass a class argument to the describe method instead of a string with the class name,
# because with a string, you cannot access its instance. With a class argument, you have access to the implicit subject.
# And this instance is lazily-loaded, isolated between tests, but persists within the body of each example.
