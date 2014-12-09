require 'rails_helper'

feature "AddQuestions", :type => :feature do

  scenario "Posting new question with valid attributes" do
    visit root_path
    fill_in "question_content"
    # expect(page).to have_content "Welcome, #{user.name}"
  end

  # scenario "Signing in with invalid credentials" do
  #   sign_in(user, "hello")
  #   expect(page).to have_content 'The Email and Password combination you entered does not match'
  # end
end
