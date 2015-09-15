require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  def test_responds
    assert_respond_to @user, :name
    assert_respond_to @user, :email
    assert_respond_to @user, :password_digest
    assert_respond_to @user, :password
    assert_respond_to @user, :password_confirmation
    assert_respond_to @user, :remember_token
    assert_respond_to @user, :authenticate
    assert_respond_to @user, :admin
    assert_respond_to @user, :lists
    assert_respond_to @user, :items
    assert_respond_to @user, :user_list_permissions
  end

  def test_valid
    assert @user.valid?
    assert !@user.admin?

    @user.name = ' '
    assert @user.invalid?
  end

  def test_name
    assert_equal "Example User", @user.name

    @user.name = ' '
    assert @user.invalid?, "User name can't be blank"
  end

  def test_with_admin_attribute_set_to_true
    @user.save!
    @user.toggle!(:admin)
    assert @user.admin?
  end

  def test_when_name_is_not_present
    @user.name = " "
    assert @user.invalid?
  end


  def test_when_name_is_too_long
    @user.name = "a" * 51
    assert @user.invalid?
  end


  def test_when_email_is_not_present
    @user.email = " "
    assert @user.invalid?
  end

  def test_when_email_format_is_invalid
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid?
    end
  end


  def test_when_email_format_is_valid
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?
    end
  end

  def test_when_email_address_is_already_taken
    user_with_same_email = @user.dup
    user_with_same_email.email = @user.email.upcase
    user_with_same_email.save
    assert @user.invalid?
  end

  def test_email_address_with_mixed_case
    mixed_case_email = "Foo@ExAMPle.CoM"

    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  def test_when_password_is_not_present
    @user.password = @user.password_confirmation = " "
    assert @user.invalid?
  end

  def test_when_password_does_not_match_confirmation
    @user.password_confirmation = "mismatch"
    assert @user.invalid?
  end

  def test_when_password_confirmation_is_nil
    @user.password_confirmation = nil
    assert @user.invalid?
  end


  def test_return_value_of_authenticate_method
    @user.save
    found_user = User.find_by_email(@user.email)

    # describe "with valid password" do
    #   it { should == found_user.authenticate(@user.password) }
    # end
    assert_equal @user, found_user.authenticate(@user.password)

    # describe "with invalid password" do
      # let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      user_for_invalid_password = found_user.authenticate("invalid")
      assert_not_equal @user, user_for_invalid_password
      assert !user_for_invalid_password

      # it { should_not == user_for_invalid_password }
      # specify { user_for_invalid_password.should be_false }
    # end
  end

  def test_with_a_password_that_is_too_short
    @user.password = @user.password_confirmation = "a" * 5
    assert @user.invalid?
  end

  def test_remember_token
    @user.save
    assert !@user.remember_token.blank?
  end

  def test_list_associations
    @user.save
    older_list = FactoryGirl.create(:list, user: @user, created_at: 1.day.ago)
    newer_list = FactoryGirl.create(:list, user: @user, created_at: 1.hour.ago)

    # it "should have the right lists in the right order" do
      # @user.lists.should == [newer_list, older_list]
    # end
    assert_equal [newer_list, older_list], @user.lists

    # it "should destroy associated lists" do
    lists = @user.lists.dup
    @user.destroy
    # assert lists.empty?
    assert lists.blank?, "#{lists.inspect} is not blank"
    # end

  end

end
