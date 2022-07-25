require 'rails_helper'

feature 'Posts Show' do
  scenario 'Displaying the post detail page', js: true do
    post = create :post

    visit root_path
    click_on post.title

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.url)
    expect(page).to have_content(post.tagline)
  end

  scenario 'Do not show the comments if the post has no comments', js: true do
    post = create :post, title: 'Lorem ipsum dolor sit amet'

    visit root_path
    click_on post.title

    expect(page).not_to have_content 'Comments'
    expect(page).not_to have_selector "#comments"
  end

  scenario 'Show the comments if the post has comments', js: true do
    post = create :post, title: 'Lorem ipsum dolor sit amet'
    comment = create :comment, post: post

    visit root_path
    click_on post.title

    comments_section = find('#comments')

    expect(comments_section).to have_content 'Comments'
    expect(comments_section).to have_content comment.user.name
    expect(comments_section).to have_content comment.text
  end

  scenario 'Show new comment form when user is logged in', js: true do
    post = create :post
    user = create :user

    visit root_path
    login email: user.email, password: user.password
    click_on post.title

    comments_section = find('#comments')

    expect(comments_section).to have_selector '#create-comment'
  end

  scenario 'Do not show new comment form when user is not logged in', js: true do
    post = create :post

    visit root_path
    click_on post.title

    expect(page).not_to have_selector '#comments'
    expect(page).not_to have_selector '#create-comment'
  end

  scenario 'Create comment properly', js: true do
    post = create :post
    user = create :user

    text = 'Lorem ipsum dolor sit amet'

    visit root_path
    login email: user.email, password: user.password
    click_on post.title

    comments_section = find('#comments')
    comments_section.fill_in 'Add a comment...', with: text
    comments_section.find('#create-comment button').click
    
    comments_list_section = find('#comments-list')
    expect(comments_list_section).to have_content text
  end

  scenario 'Do not comment with empty text', js: true do
    post = create :post
    user = create :user

    text = ''

    visit root_path
    login email: user.email, password: user.password
    click_on post.title

    comments_section = find('#comments')
    comments_section.fill_in 'Add a comment...', with: text
    comments_section.find('#create-comment button').click
    
    expect(comments_section).not_to have_selector'#comments-list'
  end
end
