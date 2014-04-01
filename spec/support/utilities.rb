include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well
  cookies[:remember_token] = user.remember_token
end

def set_list_updated_at_ts_back(list)
  list.updated_at = 30.seconds.ago
  list.save!(validate: false)
end

def create_list(list_name)
  visit root_path
  fill_in 'list_name', with: list_name
  click_button "Post"
end

def create_item(item_content)
  fill_in 'item_content', with: item_content
  click_button "Post"
end
