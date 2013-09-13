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
    name "Lorum ipsum"
    user
  end

  factory :item do
    name "Ispo facto meeny moe... MAGICO!"
    list
  end
end
