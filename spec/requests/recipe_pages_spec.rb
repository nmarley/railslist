require 'spec_helper'

describe "Recipe pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "recipe creation" do
    before { visit new_recipe_path }

    describe "with invalid information" do
      it "should not create a recipe" do
        expect { click_button "Update" }.not_to change(Recipe, :count)
      end

      describe "error messages" do
        before { click_button "Update" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before {
        fill_in 'recipe_name', with: "KaleNutsCo"
        fill_in 'recipe_ingredients', with: "2 cups kale\ncoconut water from 1 coconut\n1/2 cup walnuts\n"
        fill_in 'recipe_instructions', with: "put everything in VitaMix and blend"
      }
      it "should create a recipe" do
        expect { click_button "Update" }.to change(Recipe, :count).by(1)
      end
    end
  end

  describe "recipes_index" do
    context "viewing recipe index while signed in" do
      before { visit recipes_path }
      it { should have_selector('h1', text: 'Recipes') }
    end

    context "viewing recipe index while signed out" do
      before do
        click_link "Sign out"
        visit recipes_path
      end
      it { should have_selector('div.alert.alert-notice',
                                text: 'Please sign in.') }
    end
  end

end

