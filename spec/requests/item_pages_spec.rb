require 'spec_helper'

describe "Item pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "item creation" do
    # TODO: this should be a create_list test helper
    before do
      list_name = "Lorem Ipsum"
      visit root_path
      fill_in 'list_name', with: list_name
      click_button "Post"
      click_link list_name
    end

    describe "with invalid information" do
      it "should not create an item" do
        expect { click_button "Post" }.not_to change(Item, :count)
      end
      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'item_content', with: "Lorem Ipsum" }
      it "should create an item" do
        expect { click_button "Post" }.to change(Item, :count).by(1)
      end
    end
  end

end
