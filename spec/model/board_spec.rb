require 'rails_helper'

RSpec.describe Board, type: :model do
  subject { create(:board, name: "Example Board", email: "board@example.com", width: 5, height: 5) }

  # Test for valid attributes
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  # Test for name validation
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  # Test for email validation
  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  # Test for width validation
  it "is not valid without a width" do
    subject.width = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a non-numeric width" do
    subject.width = "abc"
    expect(subject).to_not be_valid
  end

  # Test for height validation
  it "is not valid without a height" do
    subject.height = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a non-numeric height" do
    subject.height = "def"
    expect(subject).to_not be_valid
  end
end