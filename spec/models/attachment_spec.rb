require 'spec_helper'

describe Attachment do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    @attachment = user.attachments.build(FactoryGirl.attributes_for(:attachment))
  end

  subject { @attachment }

  it { is_expected.to respond_to(:media_file_name) }
  it { is_expected.to respond_to(:media_content_type) }
  it { is_expected.to respond_to(:media_file_size) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:user)    }

  it { is_expected.to be_valid }

  # class methods
  specify { expect(Attachment).to respond_to(:most_recent_first) }
  specify { expect(Attachment).to respond_to(:for_user) }

  describe '#user' do
    subject { super().user }
    it { is_expected.to eq(user) }
  end

  describe '.for_user' do
    before do
      subject.save!
      user2 = FactoryGirl.create(:user, name: 'Gandalf')
      attachment2 = user2.attachments.create(FactoryGirl.attributes_for(:attachment))
    end

    it 'gets attachments for_user' do
      @results = Attachment.for_user(user.id)
      expect(Attachment.count).to eq(2)
      expect(Attachment.pluck(:user_id).uniq.size).to eq(2)
      expect(@results.pluck(:id).sort).to eq(user.attachments.pluck(:id).sort)
    end
  end

  describe '#create' do
    it 'save attachment to db' do
      expect { @attachment.save }.to change(Attachment.for_user(user.id), :count).by(1)
    end
  end
end
