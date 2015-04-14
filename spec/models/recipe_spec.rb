require 'spec_helper'

describe Recipe do
  before do
    @recipe = FactoryGirl.build(:recipe)
  end

  subject { @recipe }

  it { is_expected.to respond_to(:name)  }
  it { is_expected.to respond_to(:instructions) }
  it { is_expected.to respond_to(:ingredients) }

  describe "when name is not present" do
    before { @recipe.name = " " }
    it { is_expected.not_to be_valid }
  end

  describe "when name is too long" do
    before { @recipe.name = "a" * 500 }
    it { is_expected.not_to be_valid }
  end

  describe "when ingredients list is empty" do
    before { @recipe.ingredients = " " }
    it { is_expected.not_to be_valid }
  end


end
