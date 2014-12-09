FactoryGirl.define do
  factory :question do
    title Faker::Lorem.words(3).join(' ')
    content Faker::Lorem.paragraph
  end

  # This will use the User class (Admin would have been guessed)
  factory :answer do
    title Faker::Lorem.words(3).join(' ')
    content  Faker::Lorem.paragraph
  end
end