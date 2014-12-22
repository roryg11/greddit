require 'rails_helper'

feature 'CRUD posts' do
  scenario 'Write a new post' do
    visit root_path
    click_on 'new-post-action'
    fill_in "Title", with: "I love gReddit"
    fill_in "Content", with: "It's so much better than Reddit"
    click_on "submit-post-action"

    expect(page).to have_content("I love gReddit")
    expect(page).to have_content("It's so much better than Reddit")
  end

  scenario 'edit a post' do
    post = Post.create!(
      title: "I love gReddit",
      content: "It's so much better than Reddit"
    )


    visit root_path
    click_on "edit-post-#{post.id}-action"
    fill_in "Title", with: "I hate gReddit"
    fill_in "Content", with: "It sucks"
    click_on "submit-post-action"

    expect(page).to have_content("I hate gReddit")
    expect(page).to have_content("It sucks")
  end

  scenario 'delete a post' do
    post = Post.create!(
    title: "I love gReddit",
    content: "It's so much better than Reddit"
    )

    visit root_path
    click_on "delete-post-#{post.id}-action"

    expect(page).to have_content("Post successfully deleted.")
  end
  scenario 'view an individual post' do
    post = Post.create!(
    title: "I love gReddit",
    content: "It's so much better than Reddit"
    )

    visit root_path
    click_on "show-post-#{post.id}-action"

    expect(page).to have_content("I love gReddit")
  end

  scenario 'view an index of posts' do
    Post.create!(
    title: "I love gReddit",
    content: "It's so much better than Reddit"
    )

    Post.create!(
    title: "Reddit sucks",
    content: "Reddit is just a stream of silly information."
    )

    visit root_path

    expect(page).to have_content("Reddit sucks")
    expect(page).to have_content("I love gReddit")
  end
end
