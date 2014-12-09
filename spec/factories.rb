FactoryGirl.define do
  factory :question do
    title "title"
    content "content"
  end

  # This will use the User class (Admin would have been guessed)
  factory :answer do
    title "title"
    content  "content"
  end
end