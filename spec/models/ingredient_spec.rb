require 'spec_helper'

describe Ingredient do
  before do
    @ingredient = FactoryGirl.build(:ingredient)
  end

  subject { @ingredient }

  it { should respond_to(:name) }
  it { should respond_to(:recipes) }

  describe "when name is not present" do
    before { @ingredient.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @ingredient.name = "a" * 500 }
    it { should_not be_valid }
  end


end
