require 'spec_helper'

describe Recipe do
  before do
    @recipe = FactoryGirl.build(:recipe)
  end

  subject { @recipe }

  it { should respond_to(:name)  }
  it { should respond_to(:instructions) }
  it { should respond_to(:ingredients) }

  describe "when name is not present" do
    before { @recipe.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @recipe.name = "a" * 500 }
    it { should_not be_valid }
  end

  describe "when ingredients list is empty" do
    before { @recipe.ingredients = " " }
    it { should_not be_valid }
  end


end
