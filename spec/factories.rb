FactoryGirl.define do
  factory :question do
    title Faker::Lorem.words(3).join(' ')
    content Faker::Lorem.paragraph
  end

  factory :invalid_question, parent: :question do
    title nil
  end

  factory :answer do
    title Faker::Lorem.words(3).join(' ')
    content  Faker::Lorem.paragraph
    question
  end

  factory :invalid_answer, parent: :answer do
    title nil
  end
end