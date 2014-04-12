require 'spec_helper'

describe "Attachment pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "attachment creation" do
    before do
      list_name = "Grocery list"
      Timecop.freeze(1.hour.ago) do
        create_list list_name
      end
      click_link list_name
    end

    # obviously a placeholder for the actual test
    it "should update list timestamp" do
      # grab the list id and List instance
      list_id = find('#item_list_id').value.to_i
      @list = List.find(list_id)

      # make a temp file for uploading
      tempfile = Tempfile.new('foo.txt')
      tempfile.write("Hello, World!\n")
      tempfile.close

      # add/upload attachment
      attach_file('attachment[media]', tempfile.path)

      # verify timestamp for list has been updated
      expect { click_button 'Add Attachment';@list.reload }.to change(@list, :updated_at)
    end

  end

end

