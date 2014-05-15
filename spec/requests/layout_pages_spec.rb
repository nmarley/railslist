require 'spec_helper'

describe "Layout pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "header" do
    before { visit root_path }

    it "should have the right links on the layout" do
      expect(page).to have_link 'Home'
      expect(page).to have_link 'Help'
      expect(page).to have_link 'Item Search'
      expect(page).to have_link 'Files'
      expect(page).to have_link 'Recipes'
      expect(page).to have_link 'Users'
      expect(page).to have_link 'Account'
      expect(page).to have_link 'Profile'
      expect(page).to have_link 'Settings'
      expect(page).to have_link 'Sign out'

      click_link "Files"
      expect(page).to have_selector 'title', text: full_title('My Files')

      click_link "Recipes"
      expect(page).to have_selector 'title', text: full_title('Recipes')

      click_link "Users"
      expect(page).to have_selector 'title', text: full_title('All users')

      click_link "Item Search"
      expect(page).to have_selector 'title', text: full_title('Item Search')
    end
  end

end
