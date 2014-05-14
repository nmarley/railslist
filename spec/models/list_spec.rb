require 'spec_helper'

describe List do
  let(:user) { FactoryGirl.create(:user) }
  before { @list = user.lists.build(name: "Grocery list") }

  subject { @list }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user)    }

  it { should be_valid }

  # class methods
  specify { expect(List).to respond_to(:search) }

  describe '#user' do
    subject { super().user }
    it { should == user }
  end

  describe '.search' do
    before { subject.save! }
    it 'searches' do
      @results = List.search('Grocery')
      expect(@results.size).to eq(1)
    end
  end


  describe "when user_id is not present" do
    before { @list.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @list.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @list.name = "a" * 201 }
    it { should_not be_valid }
  end

end

