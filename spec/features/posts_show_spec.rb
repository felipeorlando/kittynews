require 'rails_helper'

feature 'Posts Show' do
  scenario 'Displaying the post detail page', js: true do
    post = create :post

    visit root_path
    click_on post.title

    expect(page).to have_content 'Comments'
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.url)
    expect(page).to have_content(post.tagline)
  end
end
