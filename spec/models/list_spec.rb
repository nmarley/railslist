require 'spec_helper'

describe List do
  let(:user) { FactoryGirl.create(:user) }
  before { @list = user.lists.build(name: "Grocery list") }

  subject { @list }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:user)    }

  it { is_expected.to be_valid }

  # class methods
  specify { expect(List).to respond_to(:search) }
  specify { expect(List).to respond_to(:for_user) }

  describe '#user' do
    subject { super().user }
    it { is_expected.to eq(user) }
  end

  describe '.search' do
    before { subject.save! }
    it 'searches' do
      @results = List.search('Grocery')
      expect(@results.size).to eq(1)
    end
  end

  describe '.for_user' do
    before { subject.save! }
    it 'gets lists for_user' do
      @results = List.for_user(user.id)
      expect(@results.pluck(:id).sort).to eq(user.lists.pluck(:id).sort)
    end
  end

  describe "when user_id is not present" do
    before { @list.user_id = nil }
    it { is_expected.not_to be_valid }
  end

  describe "with blank name" do
    before { @list.name = " " }
    it { is_expected.not_to be_valid }
  end

  describe "with name that is too long" do
    before { @list.name = "a" * 201 }
    it { is_expected.not_to be_valid }
  end

end

