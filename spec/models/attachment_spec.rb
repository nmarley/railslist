require 'spec_helper'

describe Attachment do
  let!(:list) { FactoryGirl.create(:list) }

  describe "when adding attachment" do
    specify "list should be touched" do
      Timecop.freeze(15.minutes.ago) do
        list.touch
      end

      expect { FactoryGirl.create(:attachment, list: list) }.to change(list, :updated_at)
    end
  end

end
