require 'spec_helper'

describe Item do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    @list = user.lists.build(name: "Grocery list")
    @list.save!
    @item = @list.items.build(content: "Organic Kale")
  end

  subject { @item }

  it { should respond_to(:content) }
  it { should respond_to(:list_id) }
  it { should respond_to(:list)    }

  it { should be_valid }

  # class methods
  specify { expect(Item).to respond_to(:search) }

  describe '#list' do
    subject { super().list }
    it { should == @list }
  end

  describe '.search' do
    before { subject.save! }
    it 'searches' do
      @results = Item.search('kale')
      expect(@results.size).to eq(1)
    end
  end


  describe "when list_id is not present" do
    before { @item.list_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @item.content = " " }
    it { should_not be_valid }
  end

end

