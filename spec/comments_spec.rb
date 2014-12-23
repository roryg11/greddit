require 'rails_helper'

feature 'CRUDing comments' do
  scenario 'user can add a comment on a post show page' do
    post = Post.create!(
      title: "gReddit is so cool",
      content: "gReddit is a pretty good place to practice Ruby on Rails"
    )

    visit root_path
    click_on "show-post-#{post.id}-action"
    click_on "add-comment-to-post-#{post.id}-action"
    fill_in "Comment", with: "I'm not sure. I think I like Reddit better."
    click_on 'submit-comment-action'

    expect(page).to have_content("Comment succcessfully added.")
  end
  scenario 'user can edit a comment on a post show page' do
    post = Post.create!(
    title: "gReddit is so cool",
    content: "gReddit is a pretty good place to practice Ruby on Rails"
    )

    comment = Comment.create!(
      content: "I'm not sure. I think I like Reddit better.",
      post_id: (post.id)
    )

    visit post_path(post)
    click_on "edit-comment-#{comment.id}-action"
    fill_in "Comment", with: "Actually I totally agree."
    click_on "submit-comment-action"

    expect(page).to have_content("Comment successfully updated.")
  end
  scenario 'user can delete a comment on a post show page' do
    post = Post.create!(
    title: "gReddit is so cool",
    content: "gReddit is a pretty good place to practice Ruby on Rails"
    )

    comment = Comment.create!(
    content: "I'm not sure. I think I like Reddit better.",
    post_id: (post.id)
    )

    visit post_path(post)
    click_on "delete-comment-#{comment.id}-action"

    expect(page).to have_content("Comment was successfully deleted.")
  end
  scenario 'user can see all comments on the post show page' do
    post = Post.create!(
    title: "gReddit is so cool",
    content: "gReddit is a pretty good place to practice Ruby on Rails"
    )

    comment = Comment.create!(
    content: "I'm not sure. I think I like Reddit better.",
    post_id: (post.id)
    )

    comment = Comment.create!(
    content: "Nah this one is awesome.",
    post_id: (post.id)
    )

    visit post_path(post)

    expect(page).to have_content("I'm not sure. I think I like Reddit better.")
    expect(page).to have_content("Nah this one is awesome.")
  end
end
