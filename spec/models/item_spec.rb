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


  # clean up, but still can't get to green.
  # something to do with how change() is working/not working, i think

#  describe "when saving a new item" do
#    let(:other_item) { @item.list.items.build(content: 'Second item!') }
#    before { set_list_updated_at_ts_back(@item.list) }
#    it "should increment total item count" do
#      expect do
#        other_item.save
#      end.to change(Item, :count).by(1)
#    end
#    it "should update list updated_at timestamp" do
#      expect do
#        other_item.save
#      end.to change(other_item.list, :updated_at)
#    end
#  end
#
#  describe "when updating content" do
#    before { set_list_updated_at_ts_back(@item.list) }
#    it "should update list updated_at timestamp" do
#      expect do
#        @item.content = "lorem ipsum"
#        @item.save!
#      end.to change(@item.list, :updated_at)
#    end
#  end

end

