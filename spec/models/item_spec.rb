require 'spec_helper'

describe Item do
  let!(:user) { FactoryGirl.create(:user) }
  #let!(:list) { user.lists.build(name: "Lorem Ipsum") }
  #before { @item = list.items.build(content: "Ispo facto meeny moe") }

  before do
    @list = user.lists.build(name: "Lorem Impsum")
    @list.save!
    @item = @list.items.build(content: "Ispo facto meeny moe")
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

end

