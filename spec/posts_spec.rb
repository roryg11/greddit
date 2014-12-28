require 'rails_helper'

feature 'CRUD posts' do
  scenario 'A Signed in User can Write a new post' do
    user = User.create!(
      username: "Bob",
      email: "Bob@Bob.com",
      password: "bob",
      password_confirmation: "bob"
    )

    visit root_path
    click_on 'sign-in-form'
    fill_in "E-mail", with: "Bob@Bob.com"
    fill_in "Password", with: "bob"
    click_on "signin-submit-action"
    click_on 'new-post-action'
    fill_in "Title", with: "I love gReddit"
    fill_in "Content", with: "It's so much better than Reddit"
    click_on "submit-post-action"

    expect(page).to have_content("I love gReddit")
    expect(page).to have_content("It's so much better than Reddit")
    expect(page).to have_content("posted by Bob")
  end

  scenario 'A signed in user can edit a post' do
    user = User.create!(
    username: "Bob",
    email: "Bob@Bob.com",
    password: "bob",
    password_confirmation: "bob"
    )

    post = Post.create!(
      title: "I love gReddit",
      content: "It's so much better than Reddit",
      user_id: "#{user.id}"
    )

    visit root_path
    #signin action
    click_on 'sign-in-form'
    fill_in "E-mail", with: "Bob@Bob.com"
    fill_in "Password", with: "bob"
    click_on "signin-submit-action"

    #edit post action
    click_on "edit-post-#{post.id}-action"
    fill_in "Title", with: "I hate gReddit"
    fill_in "Content", with: "It sucks"
    click_on "submit-post-action"

    expect(page).to have_content("I hate gReddit")
    expect(page).to have_content("It sucks")
  end

  scenario 'a signed in user can delete their own post' do
    user = User.create!(
    username: "Bob",
    email: "Bob@Bob.com",
    password: "bob",
    password_confirmation: "bob"
    )

    post = Post.create!(
    title: "I love gReddit",
    content: "It's so much better than Reddit",
    user_id: "#{user.id}"
    )


    visit root_path
    #signin action
    click_on 'sign-in-form'
    fill_in "E-mail", with: "Bob@Bob.com"
    fill_in "Password", with: "bob"
    click_on "signin-submit-action"
    click_on "delete-post-#{post.id}-action"

    expect(page).to have_content("Post successfully deleted.")
  end

  scenario 'any user can view an individual post without signing in' do
    user = User.create!(
    username: "Bob",
    email: "Bob@Bob.com",
    password: "bob",
    password_confirmation: "bob"
    )

    post = Post.create!(
    title: "I love gReddit",
    content: "It's so much better than Reddit",
    user_id: "#{user.id}"
    )

    visit root_path
    click_on "show-post-#{post.id}-action"

    expect(page).to have_content("I love gReddit")
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
  end

  scenario 'view an index of posts' do
    user = User.create!(
    username: "Bob",
    email: "Bob@Bob.com",
    password: "bob",
    password_confirmation: "bob"
    )

    Post.create!(
    title: "I love gReddit",
    content: "It's so much better than Reddit",
    user_id: "#{user.id}"
    )

    Post.create!(
    title: "Reddit sucks",
    content: "Reddit is just a stream of silly information.",
    user_id: "#{user.id}"
    )

    visit root_path

    expect(page).to have_content("Reddit sucks")
    expect(page).to have_content("I love gReddit")
    expect(page).to have_content("posted by Bob")
  end
end

feature 'When a user is not signed in' do
  scenario 'User cannot create a post'
  scenario 'User cannot edit or delete posts'
end

feature 'User can only edit their own content' do
  scenario 'User cannot edit or delete posts belonging to anther user'
end
