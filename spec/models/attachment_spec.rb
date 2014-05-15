require 'spec_helper'

describe Attachment do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    @attachment = user.attachments.build(FactoryGirl.attributes_for(:attachment))
  end

  subject { @attachment }

  it { should respond_to(:media_file_name) }
  it { should respond_to(:media_content_type) }
  it { should respond_to(:media_file_size) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user)    }

  it { should be_valid }

  # class methods
  specify { expect(Attachment).to respond_to(:most_recent_first) }
  specify { expect(Attachment).to respond_to(:for_user) }

  describe '#user' do
    subject { super().user }
    it { should == user }
  end

  describe '.for_user' do
    before { subject.save! }
    it 'gets lists for_user' do
      @results = List.for_user(user.id)
      expect(@results.pluck(:id).sort).to eq(user.lists.pluck(:id).sort)
    end
  end

  describe '#create' do
    before { user.save! }
    expect { @attachment.save }.to change(Attachment.for_user(user.id), :count).by(1)
  end
end
