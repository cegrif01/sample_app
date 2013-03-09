FactoryGirl.define do
  factory :user do
    name     "Charles Griffin"
    email    "cegrif01@gmail.com"
    password "password"
    password_confirmation "password"
  end
end