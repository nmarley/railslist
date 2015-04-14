require 'spec_helper'

describe Item do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    @list = user.lists.build(name: "Grocery list")
    @list.save!
    @item = @list.items.build(content: "Organic Kale")
  end

  subject { @item }

  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:list_id) }
  it { is_expected.to respond_to(:list)    }

  it { is_expected.to be_valid }

  # class methods
  specify { expect(Item).to respond_to(:search) }
  specify { expect(Item).to respond_to(:for_user) }

  describe '#list' do
    subject { super().list }
    it { is_expected.to eq(@list) }
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
    it { is_expected.not_to be_valid }
  end

  describe "with blank content" do
    before { @item.content = " " }
    it { is_expected.not_to be_valid }
  end

end

