require 'spec_helper'

describe List do
  let(:user) { FactoryGirl.create(:user) }
  before { @list = user.lists.build(name: "Lorem ipsum") }

  subject { @list }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user)    }
  its(:user) { should == user }

  it { should be_valid }


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

