require 'rails_helper'

feature 'Posts Index' do
  scenario 'Displaying the posts on the homepage', js: true do
    post_1 = create :post
    post_2 = create :post

    visit root_path

    expect(page).to have_content post_1.title
    expect(page).to have_content post_2.title
  end

  scenario 'Show post with likes number', js: true do
    post = create :post
    create :like, post: post
    create :like, post: post

    visit root_path

    expect(find('#like-link')).to have_content '🔼 2'
  end

  scenario 'Like counter is a link to login page when user is logged out', js: true do
    post = create :post

    visit root_path

    find('#like-link').click

    expect(page).to have_content 'Log in'
  end

  scenario 'Likes a post when user is logged in', js: true do
    user = create :user
    post = create :post

    visit root_path

    login(email: user.email, password: user.password)

    expect(find('#like-button')).to have_content '🔼 0'

    find('#like-button').click

    expect(find('#like-button')).to have_content '🔽 1'
  end

  scenario 'Unlikes a post when user is logged in', js: true do
    user = create :user
    post = create :post
    create :like, post: post, user: user

    visit root_path

    login(email: user.email, password: user.password)

    expect(find('#like-button')).to have_content '🔽 1'

    find('#like-button').click

    expect(find('#like-button')).to have_content '🔼 0'
  end
end
