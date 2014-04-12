FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :list do
    name "Garden Seed Wish List for #{Date.today.year}"
    user
  end

  factory :item do
    content "An Item - Tomato Seeds"
    list
  end

  factory :recipe do
    name "Sweet Lemon Thai Basil Curry"
    instructions "Heat the oil in a wok. Add all ingredients into wok. Cook everything, then eat."
  end

  factory :ingredient do
    name "sweet potato"
  end

  factory :attachment do
    media_file_name "README.txt"
    media_content_type "text/plain"
    media_file_size 1071
    list
  end

end
