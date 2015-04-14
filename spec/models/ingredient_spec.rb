require 'spec_helper'

describe Ingredient do
  before do
    @ingredient = FactoryGirl.build(:ingredient)
  end

  subject { @ingredient }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:recipes) }

  describe "when name is not present" do
    before { @ingredient.name = " " }
    it { is_expected.not_to be_valid }
  end

  describe "when name is too long" do
    before { @ingredient.name = "a" * 500 }
    it { is_expected.not_to be_valid }
  end


end
