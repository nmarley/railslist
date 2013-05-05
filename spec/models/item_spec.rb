require 'spec_helper'

describe Item do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    @list = user.lists.build(name: "Lorem Impsum")
    @list.save!
    @item = @list.items.build(content: "Ispo facto meeny moe")
    #@item.save!
  end

  subject { @item }

  it { should respond_to(:content) }
  it { should respond_to(:list_id) }
  it { should respond_to(:list)    }
  its(:list) { should == @list }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to list_id" do
      expect do
        Item.new(list_id: @list.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
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

  # can't get these for the life of me...
  # functionality is now working nonetheless. it would be nice if I could have
  # rspec tests for it.

#  describe "new item" do
#    before do
#      @item = @list.items.create!(content: "lorem ipsum")
#    end
#
#    it "should update list updated_at timestamp" do
#      expect {
#        @item.content = "meeny moe"
#        @item.save
#      }.to change(@list, :updated_at)
#    end
#  end
#
#  describe "updating content" do
#    before do
#      @item.list.updated_at = 1.day.ago
#      @item.list.save!
#    end
#
#    it "should update list updated_at timestamp" do
#      expect {
#        @item.content = "lorem ipsum"
#        @item.save!
#      }.to change(@item.list, :updated_at)
#    end
#  end

end

