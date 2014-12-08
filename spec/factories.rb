FactoryGirl.define do
  factory :question do
    title
    content
  end

  # This will use the User class (Admin would have been guessed)
  factory :answer do
    first_name "Admin"
    last_name  "User"
    admin      true
  end
end