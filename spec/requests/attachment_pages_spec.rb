require 'spec_helper'

describe "Attachment pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "attachment creation" do
    before do
      list_name = "Lorem Ipsum"
      Timecop.freeze(1.hour.ago) do
        create_list list_name
      end
      click_link list_name
    end

    # obviously a placeholder for the actual test
    it "should update list timestamp" do
      # add/upload attachment
      # verify timestamp for list has been updated
      assert true
    end

  end

end

