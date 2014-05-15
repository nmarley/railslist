require 'spec_helper'

describe "Attachment pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "attachment creation" do
    before { visit files_path }

    it "should add a new file to the index" do

      # count the number of 'li' elements under '.attachments' in the HTML
      file_page_file_count = lambda {
        find('.attachments').all('li').count
      }

      # make a temp file for uploading
      tempfile = Tempfile.new('foo.txt')
      tempfile.write("Hello, World!\n")
      tempfile.close

      # add/upload attachment
      attach_file('attachment[media]', tempfile.path)

      # verify file list on the page has been updated
      expect { click_button 'Add Attachment' }.to change(file_page_file_count, :call).by(1)
    end
  end

end
