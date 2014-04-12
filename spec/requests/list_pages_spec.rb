require 'spec_helper'

describe "List pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "list creation" do
    before { visit root_path }
    describe "with invalid information" do
      it "should not create a list" do
        expect { click_button "Post" }.not_to change(List, :count)
      end
      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end
    describe "with valid information" do
      before { fill_in 'list_name', with: "Grocery list" }
      it "should create a list" do
        expect { click_button "Post" }.to change(List, :count).by(1)
      end
    end
  end

  describe "viewing list index while signed in" do
    before { visit lists_path }
    it { should have_selector('h1', text: 'My lists') }
  end

  describe "viewing list index while signed out" do
    before do
      click_link "Sign out"
      visit lists_path
    end
    it { should have_selector('div.alert.alert-notice',
                              text: 'Please sign in.') }
  end

#  describe "list deletion" do
#    before { visit root_path }
#    let(:list) { user.lists.build( FactoryGirl.create(:list) ) }
#
#    it "should add some items" do
#      let(:i1) { list.items.build(FactoryGirl.create(:item)) }
#      let(:i2) { list.items.build(FactoryGirl.create(:item)) }
#    end
#
#  end

end

