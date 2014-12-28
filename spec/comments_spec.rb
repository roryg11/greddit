require 'rails_helper'

feature 'CRUDing comments' do
  scenario 'a signed in user can add a comment on a post show page' do
    user = User.create!(
    username: "Bob",
    email: "Bob@Bob.com",
    password: "bob",
    password_confirmation: "bob"
    )

    post = Post.create!(
      title: "gReddit is so cool",
      content: "gReddit is a pretty good place to practice Ruby on Rails",
      user_id: "#{user.id}"
    )

    visit root_path
    #sign in action
    click_on 'sign-in-form'
    fill_in "E-mail", with: "Bob@Bob.com"
    fill_in "Password", with: "bob"
    click_on "signin-submit-action"

    #add comment action
    click_on "show-post-#{post.id}-action"
    click_on "add-comment-to-post-#{post.id}-action"
    fill_in "Comment", with: "I'm not sure. I think I like Reddit better."
    click_on 'submit-comment-action'

    expect(page).to have_content("Comment succcessfully added.")
    expect(page).to have_content("posted by Bob on #{post.created_at.strftime("%b %d, %Y")}")
  end

  scenario 'a signed in user can edit a comment on a post show page' do
    user = User.create!(
    username: "Bob",
    email: "Bob@Bob.com",
    password: "bob",
    password_confirmation: "bob"
    )

    post = Post.create!(
    title: "gReddit is so cool",
    content: "gReddit is a pretty good place to practice Ruby on Rails",
    user_id: "#{user.id}"
    )

    comment = Comment.create!(
      content: "I'm not sure. I think I like Reddit better.",
      post_id: "#{post.id}",
      user_id: "#{user.id}"
    )

    #sign in action
    visit root_path
    click_on 'sign-in-form'
    fill_in "E-mail", with: "Bob@Bob.com"
    fill_in "Password", with: "bob"
    click_on "signin-submit-action"

    #edit comment action
    visit post_path(post)
    click_on "edit-comment-#{comment.id}-action"
    fill_in "Comment", with: "Actually I totally agree."
    click_on "submit-comment-action"

    expect(page).to have_content("Comment successfully updated.")
    expect(page).to have_content("Actually I totally agree.")
  end
  scenario 'user can delete a comment on a post show page' do
    user = User.create!(
    username: "Bob",
    email: "Bob@Bob.com",
    password: "bob",
    password_confirmation: "bob"
    )

    post = Post.create!(
    title: "gReddit is so cool",
    content: "gReddit is a pretty good place to practice Ruby on Rails",
    user_id: "#{user.id}"
    )

    comment = Comment.create!(
    content: "I'm not sure. I think I like Reddit better.",
    post_id: "#{post.id}",
    user_id: "#{user.id}"
    )

    #sign in action
    visit root_path
    click_on 'sign-in-form'
    fill_in "E-mail", with: "Bob@Bob.com"
    fill_in "Password", with: "bob"
    click_on "signin-submit-action"

    visit post_path(post)
    click_on "delete-comment-#{comment.id}-action"

    expect(page).to have_content("Comment was successfully deleted.")
  end
  scenario 'user can see all comments on the post show page' do
    user = User.create!(
    username: "Bob",
    email: "Bob@Bob.com",
    password: "bob",
    password_confirmation: "bob"
    )

    post = Post.create!(
    title: "gReddit is so cool",
    content: "gReddit is a pretty good place to practice Ruby on Rails",
    user_id: "#{user.id}"
    )

    comment = Comment.create!(
    content: "I'm not sure. I think I like Reddit better.",
    post_id: "#{post.id}",
    user_id: "#{user.id}"
    )

    comment_2 = Comment.create!(
    content: "Nah this one is awesome.",
    post_id: "#{post.id}",
    user_id: "#{user.id}"
    )

    visit post_path(post)

    expect(page).to have_content("I'm not sure. I think I like Reddit better.")
    expect(page).to have_content("posted by Bob on #{post.created_at.strftime("%b %d, %Y at %H:%M")}")
    expect(page).to have_content("Nah this one is awesome.")
  end
end

feature "When user is not signed in" do
  scenario 'User cannot add comments'
  scenario 'User cannot edit or delete comments'
end


feature 'User can only edit their own content' do
  scenario 'User cannot edit or delete comments belonging to anther user'
end
