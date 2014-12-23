require 'rails_helper'

feature 'registration' do
  scenario 'users can sign up' do
    visit root_path
    click_on "Sign Up"
    fill_in "Username", with: "Patti"
    fill_in "E-mail", with: "Mayonnaise@mayo.com"
    fill_in "Password", with: "doug"
    fill_in "Password Confirmation", with: "doug"
    click_on "Register"

    expect(page).to have_content("Congratulations on registering for gReddit")
  end

end

feature 'authentication' do
  scenario 'users can sign-in' do
    User.create!(
    username: "Patti",
    email: "Mayonnaise@mayo.com",
    password: "doug"
    )


    visit root_path
    click_on "sign-in-form"
    fill_in "E-mail", with: "Mayonnaise@mayo.com"
    fill_in "Password", with: "doug"
    click_on "signin-submit-action"

    expect(page).to have_content("Welcome, Patti")
  end

  scenario 'users can sign-out' do
    visit root_path
    click_on "Sign Up"
    fill_in "Username", with: "Patti"
    fill_in "E-mail", with: "Mayonnaise@mayo.com"
    fill_in "Password", with: "doug"
    fill_in "Password Confirmation", with: "doug"
    click_on "Register"
    click_on "signout-action"

    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
  end
end
